import 'package:flutter/material.dart';
import 'package:version1/page/ActionAuto.dart';
import 'package:version1/page/Actuator.dart';
import 'package:version1/page/Alarm.dart';
import 'package:version1/page/Customers.dart';
import 'package:version1/page/Dashboard.dart';
import 'package:version1/page/Devices.dart';
import 'package:version1/page/Home.dart';
import 'package:version1/page/ListCronicle.dart';
import 'package:version1/page/Moitoring_Site.dart';
import 'package:version1/page/Monitoring.dart';
import 'package:version1/page/Monthly.dart';
import 'package:version1/page/Node.dart';
import 'package:version1/page/Profile.dart';
import 'package:version1/page/Sensor.dart';
import 'package:version1/page/Site.dart';
import 'package:version1/page/Sites.dart';
import 'package:version1/page/Weekly.dart';
import 'package:version1/page/Yearly.dart';
import 'package:version1/page/auto.dart';
import 'package:version1/page/camera.dart';
import 'package:version1/page/extereme.dart';
import 'package:version1/page/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:version1/page/repeter.dart';
import 'package:version1/page/search.dart';
import 'package:version1/page/test.dart';
import 'package:version1/view/loading.dart';

import 'page/dash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
      initialRoute: '',
      routes: {
        '/Login': (context) => Login(),
        '/Home': (context) => Home(),
        '/Devices': (context) => Devices(), //zayda
        '/Site': (context) => Site(), //zayda
        '/Customers': (context) => Customers(), //zayda
        '/Camera': (context) => Camera(),
        '/Node': (context) => Node(),
        '/Profile': (context) => Profile(),
        '/Alarm': (context) => Alarm(), //zayda
        '/Sensor': (context) => Sensor(), //zayda
        '/dash': (context) => Dash(),
        '/actuator': (context) => Actuator(),
        '/dashboard': (context) => Dashboard(),
        '/test': (context) => Test(),
        '/search': (context) => Search(),
        '/monitoring': (context) => Monitoring(), //zayda
        '/Sites': (context) => Sites(),
        '/Monitoring_Site': (context) => MonitoringSite(),
        '/Automatique': (context) => Auto(),
        '/Extreme': (context) => Extreme(),
        '/Weekly': (context) => Weekly(), //zayda
        '/Yearly': (context) => Yearly(),
        '/Monthly': (context) => Monthly(), //zayda
        '/repeter': (context) => Repeter(),
        '/Cronicle': (context) => ListCronicle(),
        '/Actionauto': (context) => ActionAuto(),
      },
    );
  }
}
