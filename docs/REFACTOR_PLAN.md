# Flutter Project Refactor Plan

> Plan file for modernizing the `version1` Flutter app.
> Target: bring the project from Flutter ~2.10 / Dart 2.16 to Flutter 3.x / Dart 3.x with a maintainable architecture.

---

## 1. Context

This project (`name: version1` in [pubspec.yaml](../pubspec.yaml)) is an IoT / ThingsBoard client app. It was last updated against Flutter ~2.10 (stable revision `5f105a6…` — early 2022) and Dart SDK `>=2.16.0 <3.0.0`. The tooling, dependencies, and code patterns are now 3+ years behind current Flutter.

**Why refactor now:**

- The Dart SDK constraint blocks Dart 3 language features and null-safety improvements.
- Several core packages have breaking major-version upgrades waiting (`http`, `dio`, `cloud_firestore`, `webview_flutter`, `connectivity_plus`, `google_fonts`, `flutter_form_builder`, `syncfusion_*`).
- Deprecated widgets (`RaisedButton`, `FlatButton`) and APIs will fail to compile on Flutter 3.x.
- Android toolchain (AGP 4.1, Gradle 6.7, Kotlin 1.6, Java 8) is incompatible with modern Android Studio and Play Store targetSdk requirements.
- The code has no state-management layer, no networking abstraction, no tests, and hardcoded secrets — all of which are much cheaper to fix *during* the SDK upgrade than after.

**Intended outcome:** a project that builds cleanly on the current stable Flutter, passes `flutter analyze`, runs on recent Android/iOS, and has clean seams (API layer, state, routes) that the team can keep extending without rewriting.

---

## 2. Snapshot of the Current State

| Area | Finding |
|---|---|
| Flutter channel/revision | stable, revision `5f105a6…` (≈ Flutter 2.10, Feb 2022) — see [.metadata](../.metadata) |
| Dart SDK constraint | `>=2.16.0 <3.0.0` — see [pubspec.yaml:21](../pubspec.yaml#L21) |
| Android AGP / Gradle / Kotlin | AGP 4.1.0, Gradle 6.7, Kotlin 1.6.10, Java 8, minSdk 21 — [android/app/build.gradle](../android/app/build.gradle), [gradle-wrapper.properties](../android/gradle/wrapper/gradle-wrapper.properties) |
| iOS | No explicit `Podfile`; no `GoogleService-Info.plist` |
| Lints | `flutter_lints: ^1.0.0` via [analysis_options.yaml](../analysis_options.yaml) |
| State management | None — pure `setState` + top-level mutable globals |
| Navigation | 27 hardcoded named routes declared inside [lib/main.dart:60-87](../lib/main.dart#L60-L87) |
| Networking | Ad-hoc `http.get` / `dio` calls scattered inside widgets; no shared client |
| Secrets | Hardcoded OpenWeather API keys in `lib/page/Home.dart`; hardcoded ThingsBoard host in [lib/api.dart](../lib/api.dart), [lib/api_admin.dart](../lib/api_admin.dart), `lib/page/login.dart` |
| Models | Only [lib/model/user.dart](../lib/model/user.dart) (7 fields, no `fromJson`/`toJson`); [lib/model/alarmmodel.dart](../lib/model/alarmmodel.dart) is empty |
| File size hotspots | `lib/view/Response.dart` (≈1052 lines), `lib/page/repeter.dart` (≈968), `lib/page/Dashboard.dart` (≈752), `lib/page/Moitoring_Site.dart` (≈553) |
| Deprecated widgets | `RaisedButton` / `FlatButton` used in `lib/page/Devices.dart`, `lib/page/Sites.dart`, `lib/page/test.dart`, `lib/page/login.dart` |
| Naming | Mixed PascalCase/lowercase filenames; typo `Moitoring_Site.dart` |
| Tests | No `test/` directory exists |
| Misc | Empty stray `iot_mobile/` directory at project root |

---

## 3. Goals and Non-Goals

**Goals**

1. Compile and run on the current stable Flutter (3.x) with Dart 3.
2. Make the Android build succeed with a modern AGP/Gradle/Kotlin/Java toolchain.
3. Remove deprecated widgets and move to null-safe, sound-null-safety code.
4. Introduce a single networking layer and lift secrets out of source.
5. Introduce a light state-management layer so new screens have a clear pattern.
6. Split the largest files and normalise filenames.
7. Add a minimum smoke test so future upgrades have a safety net.

**Non-goals (explicit, core plan only)**

- Full UI redesign — tracked in §9 (enhancements).
- Rewriting the ThingsBoard integration — only wrap it behind a thin service.
- Backend / postgres work — left as-is.
- Full test coverage — we add a harness and 1–2 smoke tests only.

---

## 4. Recommended Approach (Phased)

Each phase ends at a point where `flutter run` still works. Commit at the end of every phase.

---

### Phase 0 — Safety net (½ day)

**Purpose:** establish a reversible baseline before touching anything. Every later phase will be compared against this checkpoint.

**Tasks**

1. **Branch and baseline**
   ```bash
   git checkout -b refactor/modernize
   flutter --version > docs/flutter-version-before.txt
   flutter pub outdated --show-all > docs/outdated-before.txt 2>&1 || true
   ```
   (The `|| true` lets you capture output even if resolution partially fails on the old SDK.)

2. **Smoke test scaffolding**
   Create `test/smoke_test.dart`:
   ```dart
   import 'package:flutter_test/flutter_test.dart';
   import 'package:version1/main.dart';

   void main() {
     testWidgets('App boots without crashing', (tester) async {
       await tester.pumpWidget(const MyApp());
       expect(find.byType(MyApp), findsOneWidget);
     });
   }
   ```
   Purpose: a single binary signal ("still boots?") you can run after every phase.

3. **Remove empty stubs**
   - Delete the empty `iot_mobile/` directory.
   - Delete `lib/view/menu.dart`, `lib/view/background.dart`, `lib/model/alarmmodel.dart` if confirmed empty.
   - Git records the deletions for audit.

4. **Create a working-notes file** at `docs/refactor-journal.md` — one-line entries per commit so reviewers can follow the path. Optional but highly recommended.

5. **Commit**
   ```bash
   git add -A && git commit -m "chore: establish refactor baseline"
   ```

**Exit criteria:** branch exists, smoke test file in place (may fail to compile — that's fine), empty stubs removed, baseline docs captured.

---

### Phase 1 — Toolchain upgrade (1 day)

**Purpose:** get a clean `flutter run` on current stable Flutter/Dart before touching any app code.

**Tasks**

1. **Install / pin Flutter stable**
   Recommended: use [FVM](https://fvm.app/) so the team shares one version.
   ```bash
   dart pub global activate fvm
   fvm install stable
   fvm use stable
   echo ".fvm/" >> .gitignore
   ```
   Or just ensure `flutter --version` reports a 3.24+ stable.

2. **Bump Dart SDK constraint** in [pubspec.yaml](../pubspec.yaml):
   ```yaml
   environment:
     sdk: ">=3.4.0 <4.0.0"
     flutter: ">=3.24.0"
   ```

3. **Regenerate platform scaffolding**
   From a temp directory, run `flutter create --template=app --org=com.novacture version1_scratch`, then diff its platform folders against this repo's:
   - Port [android/build.gradle](../android/build.gradle) → AGP `8.x`, Kotlin `1.9.x`, Google Services plugin `4.4.x`.
   - Port [android/gradle/wrapper/gradle-wrapper.properties](../android/gradle/wrapper/gradle-wrapper.properties) → Gradle `8.7`.
   - Port [android/app/build.gradle](../android/app/build.gradle):
     - `sourceCompatibility`/`targetCompatibility` → `JavaVersion.VERSION_17`
     - `kotlinOptions { jvmTarget = "17" }`
     - `compileSdk 34`, `targetSdk 34`, `minSdk 24`
     - `applicationId "com.novacture.version1"` (replace the placeholder `com.example.version1`)
     - NDK version line if present
   - Generate `ios/Podfile` with `platform :ios, '13.0'`; run `cd ios && pod install` once macOS is available.
   - Regenerate `android/app/src/main/AndroidManifest.xml` only if the scratch app's structure differs materially (keep your activities/permissions).

4. **Update `.metadata`** by letting `flutter create .` rewrite it (keep the `project_type: app` line intact).

5. **Upgrade linter**
   - In [pubspec.yaml](../pubspec.yaml), `flutter_lints: ^4.0.0`.
   - Keep [analysis_options.yaml](../analysis_options.yaml) default for now; tighten in Phase 3.

6. **Sanity check the empty build**
   ```bash
   flutter clean
   flutter pub get                 # will fail — that's expected
   flutter build apk --debug       # will fail — captured for Phase 2
   ```

**Exit criteria:** `flutter doctor` is clean, `flutter create .` reapplied, Android and iOS platform folders match a fresh Flutter 3.24 app.

---

### Phase 2 — Dependency upgrade (1–2 days)

**Purpose:** make `flutter pub get` resolve cleanly and the app start, one dep family at a time.

**Strategy:** upgrade in tiers, committing between each. Each tier keeps the previous green.

#### Tier A — core infrastructure

| Package | From | To | Known breaks / migration notes |
|---|---|---|---|
| `http` | 0.13.x | 1.2.x | `Client()` must be `.close()`-ed; `response.body` stays `String`. Scan every call site. |
| `dio` | 4.0.6 | 5.4.x | `DioError` → `DioException`; `options.connectTimeout` now `Duration`; `Interceptor` `onError` signature new. |
| `intl` | 0.17.0 | 0.19.x | `DateFormat` locale loading; some formats shifted. |
| `connectivity_plus` | 2.2.x | 6.x | Stream emits `List<ConnectivityResult>` not single value — update the unused stub in [lib/main.dart:45](../lib/main.dart#L45). |

#### Tier B — Firebase stack (requires FlutterFire CLI)

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=<firebase-project-id>
```

Then in [pubspec.yaml](../pubspec.yaml):
```yaml
firebase_core: ^3.6.0
cloud_firestore: ^5.4.4
```

And in [lib/main.dart](../lib/main.dart):
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
```

Audit every `.data()` / `Timestamp` call — v5 changed snapshot nullability.

#### Tier C — UI packages

| Package | From | To | Migration notes |
|---|---|---|---|
| `webview_flutter` | 3.0.x | 4.10.x | Now uses `WebViewController` + `WebViewWidget`. Completely different API. |
| `google_fonts` | 2.3.x | 6.2.x | `GoogleFonts.X().textTheme(base)` returns a full theme; hook via `theme.textTheme`. |
| `flutter_form_builder` | 7.1.x | 9.x | Field names became type-safe; `onChanged` signatures changed. |
| `syncfusion_flutter_charts` / `_gauges` | 19.4.x | 27.x | Add license registration in `main()` if community edition — free banner otherwise. |
| `table_calendar` | 3.0.5 | 3.1.x | Minor. |

#### Tier D — utilities and back-end

| Package | From | To | Notes |
|---|---|---|---|
| `postgres` | 2.4.x | 3.x | New `Connection.open()` API. Audit actual usage — may be dead code. |
| `web_socket_channel` | 2.2.x | 2.4.x | Backwards compatible. |
| `flutter_spinkit`, `percent_indicator`, `cupertino_icons` | — | latest | Low-risk. |

#### Packages to remove (confirm unused first)

Use `grep` before removing: `grouped_checkbox`, `flutter_gauge`, `widget_loading`, `blurry_modal_progress_hud`, `flutter_gallery_assets`, `snapshot`, `flutter_localized_locales`.

#### Special cases

- **`thingsboard_client ^1.0.1`** — check pub.dev for a Dart-3-compatible release. If none exists, vendor the source into `lib/core/thingsboard/` and patch null-safety. Alternatively, replace its usage with direct REST calls through `ApiClient` (Phase 4).

**Exit criteria:** `flutter pub get` clean, app launches to login, Firestore read works against dev project, smoke test passes.

---

### Phase 3 — Code modernization pass (1 day)

**Purpose:** drive `flutter analyze` to zero errors. Mechanical work — no behaviour change.

**Tasks**

1. **Run the analyzer and capture baseline**
   ```bash
   flutter analyze > docs/analyze-before.txt 2>&1 || true
   wc -l docs/analyze-before.txt
   ```

2. **Deprecated widgets** (global find-replace, case-sensitive):
   | Old | New | Files known to contain it |
   |---|---|---|
   | `RaisedButton` | `ElevatedButton` | `lib/page/Devices.dart`, `lib/page/Sites.dart`, `lib/page/test.dart`, `lib/page/login.dart` |
   | `FlatButton` | `TextButton` | `lib/page/login.dart` |
   | `accentColor: X` | `colorScheme: ColorScheme.fromSwatch().copyWith(secondary: X)` | [lib/main.dart:55-57](../lib/main.dart#L55-L57) theme block |
   | `textTheme: TextTheme(headline6: …)` | `titleLarge`, etc. (Material 3 naming) | — if you enable M3 in §9 |

3. **Null-safety sweeps**
   - Add `?` and `late` where analyzer flags. Avoid `!` — prefer checks.
   - Global variables in [lib/page/repeter.dart](../lib/page/repeter.dart), [lib/page/Home.dart](../lib/page/Home.dart), [lib/page/Devices.dart](../lib/page/Devices.dart): mark them `late` or `?` where they are genuinely mutated post-init. Mark `const` where truly constant (the hardcoded minute list in `repeter.dart`).

4. **Logging**
   - Replace every `print(` with `debugPrint(`. Final logger comes in Phase 4.
   - Quick scan: `grep -rn "print(" lib/`.

5. **Filename normalisation** (commit each rename batch separately; `git mv` preserves history)
   - `lib/page/ActionAuto.dart` → `action_auto.dart`
   - `lib/page/Actuator.dart` → `actuator.dart` (conflicts with existing lowercase `actuator.dart` — merge or rename the duplicate)
   - `lib/page/Alarm.dart` → `alarm.dart`
   - `lib/page/Customers.dart` → `customers.dart`
   - `lib/page/Dashboard.dart` → `dashboard.dart` (conflicts with `dash.dart`)
   - `lib/page/Devices.dart` → `devices.dart`
   - `lib/page/Home.dart` → `home.dart`
   - `lib/page/ListCronicle.dart` → `list_cronicle.dart`
   - `lib/page/Moitoring_Site.dart` → `monitoring_site.dart` (fix typo)
   - `lib/page/Monitoring.dart` → `monitoring.dart`
   - `lib/page/Monthly.dart` → `monthly.dart`
   - `lib/page/Node.dart` → `node.dart`
   - `lib/page/Profile.dart` → `profile.dart`
   - `lib/page/Sensor.dart` → `sensor.dart`
   - `lib/page/Site.dart` → `site.dart`
   - `lib/page/Sites.dart` → `sites.dart`
   - `lib/page/Weekly.dart` → `weekly.dart`
   - `lib/page/Yearly.dart` → `yearly.dart`
   - `lib/view/Response.dart` → `response.dart`
   After each rename: update every `import` in [lib/main.dart](../lib/main.dart) and cross-file.

6. **Run analyzer to zero errors**
   ```bash
   flutter analyze
   ```
   Fix any remaining errors; record remaining *warnings* in [docs/analyze-after.txt](./analyze-after.txt) for follow-up.

**Exit criteria:** `flutter analyze` returns zero **errors**. Warning count drops by ≥ 50 %.

---

### Phase 4 — Architecture seams (1–2 days)

**Purpose:** add the minimum structure to stop bleeding. Do NOT rewrite every feature — establish patterns and migrate one slice end-to-end as a reference.

**Target layout**

```
lib/
  main.dart                         // minimal; bootstrap only
  app/
    app.dart                        // MaterialApp + theme + localization
    router.dart                     // named-route map (go_router in §9)
  core/
    config/
      env.dart                      // dart-define getters
    network/
      api_client.dart               // single Dio + interceptors
      api_exception.dart
    logging/
      logger.dart                   // wraps `package:logger`
    result.dart                     // sealed class Success/Failure
  features/
    auth/
      data/
        auth_repository.dart
      state/
        auth_controller.dart        // Riverpod or ChangeNotifier
      ui/
        login_page.dart
    home/
    dashboard/
    devices/
    sites/
    monitoring/
    alarms/
    automation/                     // auto + action_auto + repeter + cronicle
    profile/
    weather/
  shared/
    widgets/                        // loading, response_* split from Response.dart
    models/                         // User (with fromJson/toJson) + DTOs
```

**Concrete tasks**

1. **Lift routes out of `main.dart`** → `lib/app/router.dart`:
   ```dart
   class AppRouter {
     static Map<String, WidgetBuilder> routes = {
       LoginPage.route: (_) => const LoginPage(),
       HomePage.route:  (_) => const HomePage(),
       // …
     };
   }
   ```
   Each page exposes `static const route = '/login'` etc. No more string typos.

2. **Centralize env/secrets** — `lib/core/config/env.dart`:
   ```dart
   class Env {
     static const thingsboardUrl =
         String.fromEnvironment('THINGSBOARD_URL',
             defaultValue: 'http://dev.host:19999');
     static const openweatherKey =
         String.fromEnvironment('OPENWEATHER_KEY');
   }
   ```
   Run with:
   ```
   flutter run --dart-define=THINGSBOARD_URL=https://... --dart-define=OPENWEATHER_KEY=...
   ```
   Delete the hardcoded strings from [lib/api.dart](../lib/api.dart), [lib/api_admin.dart](../lib/api_admin.dart), `lib/page/login.dart`, `lib/page/Home.dart`.

3. **Single `ApiClient`** — `lib/core/network/api_client.dart`:
   ```dart
   class ApiClient {
     final Dio _dio;
     ApiClient(String baseUrl)
         : _dio = Dio(BaseOptions(
             baseUrl: baseUrl,
             connectTimeout: const Duration(seconds: 10),
             receiveTimeout: const Duration(seconds: 15),
           )) {
       _dio.interceptors.add(_authInterceptor());
       _dio.interceptors.add(_logInterceptor());
     }
     // GET/POST/etc typed helpers…
   }
   ```
   Migrate `lib/api.dart` + `lib/api_admin.dart` (they are near-duplicates) into one `ThingsboardRepository` that uses `ApiClient`.

4. **State management** — pick **Riverpod** (see §9 rationale). Add:
   ```yaml
   flutter_riverpod: ^2.5.1
   ```
   Wire `AuthController` as the reference implementation, converting the login flow end-to-end. Leave other screens on `setState` until they are touched.

5. **Split the monoliths** (new commits per split):
   - [lib/view/Response.dart](../lib/view/Response.dart) (≈1052 lines) → `lib/shared/widgets/response/` containing `response_header.dart`, `response_chart.dart`, `response_table.dart`, `response_controller.dart`.
   - [lib/page/repeter.dart](../lib/page/repeter.dart) (≈968 lines) → move the hardcoded minute/year lists into `lib/features/automation/data/schedule_presets.dart`, state into a controller, UI into `repeter_page.dart`.
   - [lib/page/Dashboard.dart](../lib/page/Dashboard.dart) (≈752 lines) → extract chart data logic into `dashboard_controller.dart`.

6. **Models with `fromJson`/`toJson`**
   - [lib/model/user.dart](../lib/model/user.dart) — add manual `fromJson` / `toJson`.
   - Create DTOs in `lib/shared/models/` for: `Device`, `Site`, `Sensor`, `Alarm`, `TelemetryPoint`. Start from one; add others as API calls migrate.
   - (Upgrade to `freezed` + `json_serializable` covered in §9.)

**Exit criteria:** auth flow uses the new stack end-to-end; one monolith split; secrets removed from source; `grep -R "appid=" lib/ ; grep -R "91.134.146.229" lib/` returns nothing.

---

### Phase 5 — Tests, CI, and cleanup (½ day)

**Tasks**

1. **Expand `test/smoke_test.dart`**
   ```dart
   testWidgets('Login page renders', (tester) async {
     await tester.pumpWidget(const ProviderScope(child: MyApp()));
     expect(find.byType(LoginPage), findsOneWidget);
   });

   test('Router resolves core routes', () {
     expect(AppRouter.routes.containsKey(LoginPage.route), isTrue);
     expect(AppRouter.routes.containsKey(DashboardPage.route), isTrue);
     expect(AppRouter.routes.containsKey(DevicesPage.route), isTrue);
   });
   ```

2. **Update `README.md`** — add:
   - Required Flutter/Dart versions.
   - `flutterfire configure` step.
   - `--dart-define` keys (with a sample `.env.sample`).
   - How to run tests: `flutter test`.

3. **Capture the new baselines**
   ```bash
   flutter --version > docs/flutter-version-after.txt
   flutter pub outdated --show-all > docs/outdated-after.txt
   flutter analyze > docs/analyze-after.txt 2>&1 || true
   ```

4. **Open PR** `refactor/modernize` → `main` with a summary that links to this plan.

**Exit criteria:** PR open, CI green (once §9 CI is added), reviewers can trace every change to a phase.

---

## 5. Critical Files to Modify

- [pubspec.yaml](../pubspec.yaml) — SDK + deps
- [.metadata](../.metadata) — Flutter revision
- [analysis_options.yaml](../analysis_options.yaml) — lint upgrade
- [android/build.gradle](../android/build.gradle), [android/app/build.gradle](../android/app/build.gradle), [android/gradle/wrapper/gradle-wrapper.properties](../android/gradle/wrapper/gradle-wrapper.properties)
- `ios/Podfile` (to be generated)
- [lib/main.dart](../lib/main.dart) — shrink, pull routes out, add Firebase init
- [lib/api.dart](../lib/api.dart) + [lib/api_admin.dart](../lib/api_admin.dart) — merge + move behind `ApiClient`
- [lib/view/Response.dart](../lib/view/Response.dart), [lib/page/repeter.dart](../lib/page/repeter.dart), [lib/page/Dashboard.dart](../lib/page/Dashboard.dart) — split monoliths
- [lib/model/user.dart](../lib/model/user.dart) — add `fromJson` / `toJson`
- Every file under `lib/page/` using `RaisedButton` / `FlatButton`

---

## 6. Verification

After each phase, all of the following must still pass:

- `flutter pub get` — no resolution errors.
- `flutter analyze` — no errors (warnings tracked).
- `flutter test` — smoke test green.
- `flutter build apk --debug` — Android build succeeds.
- `flutter build ios --debug --no-codesign` — iOS build succeeds (macOS runner).
- **Manual smoke flow**:
  1. Launch app.
  2. Log in against the dev ThingsBoard instance.
  3. Open Home, Dashboard, Devices, Sites — no red screen.
  4. Trigger one weather fetch on Home.
  5. Check that the automation / repeter screen loads without hanging.
  6. Force-kill and relaunch — session restores (post-§9 if implementing secure token storage).

**Secret-leak guard:**
```bash
grep -RnE "appid=|91\.134\.146\.229|OpenWeather|postgres://" lib/
```
Must return zero results before the PR merges.

---

## 7. Risks and Open Questions

- **ThingsBoard client compatibility.** `thingsboard_client ^1.0.1` has seen limited maintenance. If it blocks the Dart 3 upgrade, we may need to vendor it or replace with raw REST calls through `ApiClient`. Decide during Phase 2.
- **Syncfusion license.** Jumping from 19.x to a current version may surface the free-license banner or require a community-license registration call in `main()`. Confirm with the team before upgrading.
- **Firestore data-model drift.** `cloud_firestore 3 → 5` changes how `Timestamp` and nested maps deserialize. Needs a pass through every `.data()` call site.
- **UX regressions on big screens.** `Dashboard.dart` and `Response.dart` mix layout and data logic; splitting them is the riskiest part of Phase 4. Mitigation: split in small commits, manual-test the dashboard after each.
- **Unknown:** whether the project must keep supporting the old ThingsBoard endpoint `http://91.134.146.229:19999` in production, or if dev/prod URLs should diverge. Confirm before Phase 4.
- **Unknown:** whether `postgres` is actually used at runtime (direct DB calls from mobile are usually a red flag). If unused, drop the dep and save a tier-D migration entirely.

---

## 8. Rough Effort Estimate

| Phase | Estimate |
|---|---|
| 0 — Safety net | 0.5 day |
| 1 — Toolchain | 1 day |
| 2 — Dependencies | 1–2 days |
| 3 — Code modernization | 1 day |
| 4 — Architecture seams | 1–2 days |
| 5 — Tests & cleanup | 0.5 day |
| **Total (core)** | **~5–7 days** for one engineer familiar with Flutter |

---

## 9. Proposed Enhancements (Beyond the Core Refactor)

These are **recommended** improvements that go beyond "make it compile on modern Flutter." Each stands alone — pick the subset that matches your team's priorities. Rough effort is shown in half-day units so you can mix and match.

### 9.1 Architecture & code quality

| # | Enhancement | Why | Effort |
|---|---|---|---|
| A1 | **Riverpod + code-gen** (`riverpod_generator`, `build_runner`) over plain Provider | Compile-time-safe providers, better testability, no `Provider.of<T>` boilerplate. Pays for itself once you have >3 features using state. | 1 d |
| A2 | **`freezed` + `json_serializable`** for all DTOs | Immutable models, auto `==`/`hashCode`/`copyWith`, serialization without handwriting `fromJson`. Cuts model files by ~60 %. | 1 d |
| A3 | **`go_router`** instead of named-route map | Deep links, typed routes, auth redirects, nested navigation. Named routes hit their ceiling once you need deep linking from notifications. | 1 d |
| A4 | **Repository pattern** across every feature (not just auth) | Clean separation: UI ↔ controller ↔ repository ↔ API client. Makes mocking in tests trivial. | 2 d (incremental) |
| A5 | **`Result<T, E>` sealed class** for API returns | Forces every call site to handle failure instead of swallowing exceptions. | ½ d |

### 9.2 UX & design

| # | Enhancement | Why | Effort |
|---|---|---|---|
| U1 | **Material 3** migration (`useMaterial3: true`) + a custom `ColorScheme` seeded from brand color | Current theme is a 2019-era `primarySwatch: Colors.blue`. M3 is the Flutter default. | ½ d |
| U2 | **Dark mode** support with `ThemeMode.system` | One-time setup, large UX win for an IoT app used at night / outdoors. | ½ d |
| U3 | **Responsive breakpoints** (phone / tablet / desktop via `LayoutBuilder` or `flutter_adaptive_scaffold`) | Dashboard is info-dense — tablet users currently see a stretched phone layout. | 1 d |
| U4 | **Skeleton / shimmer loaders** (`shimmer`) replacing `flutter_spinkit` full-screen spinners | Perceived-performance win, especially for slow ThingsBoard responses. | ½ d |
| U5 | **Pull-to-refresh + empty states** on list screens (Devices, Sites, Alarms) | Current pattern: silent reload on `initState`. Users can't recover from stale data. | ½ d |
| U6 | **Accessibility pass** — `Semantics` labels, contrast check, support for `MediaQuery.textScaler` | Table Calendar + gauge widgets currently fail most a11y audits. | 1 d |

### 9.3 Networking & data

| # | Enhancement | Why | Effort |
|---|---|---|---|
| N1 | **Auth-token refresh interceptor** on `ApiClient` | ThingsBoard JWT expires; right now users just get 401s until they re-log in. | ½ d |
| N2 | **Retry with exponential backoff** for transient 5xx / timeouts | IoT networks flap. One retry eliminates ~80 % of user-visible errors. | ½ d |
| N3 | **Offline cache** with `hive` or `drift` for Devices / Sites / last-known telemetry | App becomes usable on a bad connection; reduces ThingsBoard load. | 2 d |
| N4 | **Real-time telemetry via MQTT** (`mqtt_client`) or ThingsBoard WebSocket subscriptions | Polling HTTP for sensor data is expensive. MQTT is what ThingsBoard wants you to use. | 1–2 d |
| N5 | **`flutter_secure_storage`** for auth tokens (replacing any `SharedPreferences` use) | Tokens should not sit in plain prefs. | ½ d |
| N6 | **Drop `postgres` package** (or move DB access to a backend API) | Direct DB access from mobile leaks credentials and bypasses authz. Probably the single biggest security win. | ½ d – 2 d depending on what uses it |

### 9.4 Observability & security

| # | Enhancement | Why | Effort |
|---|---|---|---|
| O1 | **`logger` package** with env-gated levels, structured output | Replaces ad-hoc `print`/`debugPrint`. | ½ d |
| O2 | **Firebase Crashlytics** | Get real crash data from prod users; free tier is generous. | ½ d |
| O3 | **Firebase Analytics** or **Mixpanel** with minimal event taxonomy (`login_success`, `device_open`, `alarm_ack`) | Know which screens matter before redesigning them. | ½ d |
| O4 | **Firebase App Check** | Blocks scraped / forged clients from hitting your Firestore. | ½ d |
| O5 | **`firebase_messaging`** push notifications for alarms | Alarm screen exists but the app has no out-of-app notification path. High-value for an IoT product. | 1 d |
| O6 | **Dependency-vulnerability check** — `flutter pub outdated` in CI + Dependabot for pubspec | Prevents the next 2022-style bitrot. | ¼ d |

### 9.5 Delivery & process

| # | Enhancement | Why | Effort |
|---|---|---|---|
| D1 | **GitHub Actions CI** running `flutter analyze`, `flutter test`, `flutter build apk` on every PR | Today there is no guardrail; the 3-year bitrot is the direct consequence. | ½ d |
| D2 | **Flavors** (`dev`, `staging`, `prod`) with distinct bundle IDs, Firebase projects, and icons | Let QA install staging beside prod. Cheap with `flutter_flavorizr`. | 1 d |
| D3 | **Fastlane or Codemagic** for signed release builds | One-click release rather than manual Xcode/Gradle dances. | 1 d |
| D4 | **Widget & integration tests** for the top 3 flows (login, view device, acknowledge alarm) using `mocktail` + `patrol` or `integration_test` | Real confidence the app works; pairs with CI (D1). | 2 d |
| D5 | **`very_good_analysis`** instead of `flutter_lints` | Stricter; catches more real bugs. Flip once Phase 3 is done. | ¼ d |
| D6 | **Localization scaffolding** — `flutter_localizations` + `.arb` files (EN / FR / AR) generated by `intl_utils` | User base is likely multilingual; strings are scattered through widgets and impossible to translate today. | 1 d + per-locale translation time |

### 9.6 Recommended "enhancement bundles"

If you only do one bundle, pick by team goal:

- **Ship-ready bundle** → D1 + O1 + O2 + N1 + N5 (≈ 3 d). Gets you a production-quality release pipeline.
- **Developer-velocity bundle** → A1 + A2 + A3 + D5 (≈ 3.5 d). Makes every future feature faster to write.
- **IoT-product bundle** → N3 + N4 + O5 (≈ 4–5 d). The features users actually feel.
- **UX-polish bundle** → U1 + U2 + U3 + U4 + U5 (≈ 3 d). Visible, demo-worthy improvements.

---

## 10. Recommended Execution Order

1. Core phases 0 → 5 (5–7 d).
2. **D1 (CI)** immediately after — protects everything that follows.
3. **A3 (go_router)** and **A1 (Riverpod code-gen)** — do before any new feature work.
4. **O1 → O2 → N1 → N5** — the "ship-ready" bundle.
5. Then pick from §9.3 / §9.4 driven by real user pain.
