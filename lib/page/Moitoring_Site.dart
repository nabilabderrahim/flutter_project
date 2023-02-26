import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snapshot/snapshot.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:convert' show json, jsonDecode;
import '../api.dart';
import '../view/loading.dart';
import 'Customers.dart';
import 'Sites.dart';

class MonitoringSite extends StatefulWidget {
  const MonitoringSite({Key? key}) : super(key: key);

  @override
  State<MonitoringSite> createState() => _MonitoringSiteState();
}

String cd = '';
String postNom = '';
bool postValue1 = true;
bool loading = false;
Snapshot v2 = [] as Snapshot;
int valr = vall;
int valr1 = vall1;

class _MonitoringSiteState extends State<MonitoringSite> {
  void app() async {
    valr = vall;
    valr1 = vall1;
    setState(() {});
    super.initState();
  }

  tee() async {
    await gettoken();
    await idd();
    dev();
    acti();
  }

  final bool _running = true;
  Stream<String> _clock() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 10));
      setState(() {
        valeurr;
      });
      print('hooooo' + valeurr.toString());

      idd();
      dev();
      tee();
      MonitoringSite();
    }
  }

  void initState() {
    print('debbuu');
    print(vall1);
    print(valuer);
    print(nom);
    app();
  }

  @override
  Widget build(BuildContext context) {
    if (item_count1 == 0) {
      return Loading();
    }
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Live Monitoring"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Container(
              color: Color.fromRGBO(250, 247, 255, 1.0),
              child: Center(
                  child: StreamBuilder(
                      stream: _clock(),
                      builder: (context, v2) {
                        return ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: valr,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 25.0,
                                          crossAxisSpacing: 10.0,
                                          childAspectRatio: 1.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    {
                                      double _volumeValue =
                                          double.parse(valeurr[index]);

                                      fct(index);
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14.0))),
                                            padding: EdgeInsets.all(9),
                                            height: 175,
                                            width: 175,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 120,
                                                  width: 120,
                                                  child: SfRadialGauge(
                                                      axes: <RadialAxis>[
                                                        RadialAxis(
                                                            minimum: 0,
                                                            maximum: 100,
                                                            showLabels: false,
                                                            showTicks: false,
                                                            radiusFactor: 0.7,
                                                            axisLineStyle:
                                                                AxisLineStyle(
                                                                    color: Colors
                                                                        .black12,
                                                                    thickness:
                                                                        5),
                                                            pointers: <
                                                                GaugePointer>[
                                                              RangePointer(
                                                                  value:
                                                                      _volumeValue,
                                                                  width: 5,
                                                                  sizeUnit:
                                                                      GaugeSizeUnit
                                                                          .logicalPixel,
                                                                  gradient: const SweepGradient(
                                                                      colors: <
                                                                          Color>[
                                                                        Color(
                                                                            0xFFCC2B5E),
                                                                        Color(
                                                                            0xFF753A88)
                                                                      ],
                                                                      stops: <
                                                                          double>[
                                                                        0.25,
                                                                        0.75
                                                                      ])),
                                                            ],
                                                            annotations: <
                                                                GaugeAnnotation>[
                                                              GaugeAnnotation(
                                                                  angle: 90,
                                                                  axisValue: 5,
                                                                  positionFactor:
                                                                      0.2,
                                                                  widget: Text(
                                                                      _volumeValue
                                                                              .ceil()
                                                                              .toString() +
                                                                          cd,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Color(0xFFCC2B5E))))
                                                            ])
                                                      ]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    clee[index],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                              //    Text(valuer.toString()),
                              //  Text(nom.toString()),
                              GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: valr1,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          // Número de elementos del eje horizontal.
                                          crossAxisCount: 2,
                                          // Espaciado vertical del eje
                                          mainAxisSpacing: 25.0,
                                          // Espaciado horizontal del eje
                                          crossAxisSpacing: 10.0,
                                          // La relación de ancho, alto y largo de subcomponentes
                                          childAspectRatio: 1.0),
                                  itemBuilder:
                                      (BuildContext context, int indexx) {
                                    {
                                      print("jjjjj" + indexx.toString());
                                      print("jjjjj" + nom[indexx].toString());
                                      print(
                                          "jjjjj" + valuer[indexx].toString());

                                      return Column(children: <Widget>[
                                        Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.only(left: 1),
                                          height: 100,
                                          width: 250,
                                          child: Container(
                                            child: SwitchListTile(
                                              title: Text(
                                                nom[indexx],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14),
                                              ),
                                              value: valuer[indexx],
                                              activeColor: Colors.red,
                                              inactiveTrackColor: Colors.grey,
                                              onChanged: (bool) {},
                                              /*   onChanged: (bool value) async {
                                await apps(indexx, value);
                                print('kkkk' + value.toString());
                                print(valuer);
                                print(nom);
                                print(indexx);
                                postValue1 = valuer[indexx];
                                postNom = nom[indexx].toString();
                                print('fele5er $postNom = $postValue1');
                                postData();
                              },*/
                                              subtitle: Text(
                                                valuer[indexx].toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14),
                                              ),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                            ),
                                          ),
                                        )
                                      ]);
                                    }
                                  }),
                            ]);
                      })),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Home',
                        );
                      },
                      color: Colors.blue,
                      icon: Icon(Icons.home, color: Colors.white),
                    ),
                    label: ('Home'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Sites',
                        );
                      },
                      color: Colors.blue,
                      icon: Icon(Icons.devices, color: Colors.white),
                    ),
                    label: ('Devices'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Camera');
                      },
                      color: Colors.blue,
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                    label: ('Stream'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Profile');
                      },
                      //100,221,123
                      color: Color.fromRGBO(126, 184, 234, 1),
                      icon: Icon(Icons.supervised_user_circle,
                          color: Colors.white),
                    ),
                    label: ('Profile'),
                    backgroundColor: Colors.blue),
              ],
            ),
          );
  }

  void fct(int k) {
    String db = '';
    if (clee[k].indexOf('temperature') != -1) {
      db = '\u00b0' + 'C';
    } else if (clee[k].indexOf('humidity') != -1) {
      db = '\u0025';
    }
    cd = db;
  }

  void postData() async {
    print('4444' + postValue1.toString());

    var headers = {
      'X-Authorization': tokens,
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://91.134.146.229:19999/api/plugins/rpc/twoway/5836ae00-bfbf-11ec-8ea2-c70cb76c1d8e'));
    request.body = json.encode({
      "method": "setGpioStatus",
      "params": {"pin": 16, "enabled": postValue1},
      "timeout": "500"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('ssss' + postValue1.toString());
      print("jjj" + await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    /*try {
      final response = await post(Uri.parse(url), headers: {
        'X-Authorization': tokens
      }, body: {
        "method": "setGpioStatus",
        "params": {"pin": 16, "enabled": true},
        "timeout": "500"
      });
      print('llll' + response.body);
    } catch (err) {
      print(err);
    }*/
  }

  Future idd() async {
    print('iddii');
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/customer/' +
            idCus +
            '/deviceInfos?pageSize=10&page=0'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print("0");

      String res = await response.stream.bytesToString();
      // print("1");
      Map<String, dynamic> body = json.decode(res);
      // print("2" + body.toString());
      List id = [];
      int totl = int.parse(body["totalElements"].toString());
      for (int i = 0; i < totl; i++) {
        id.add(body["data"][i]["id"]["id"]);
      }
      //print("skander" + id.toString());
      item_count1 = totl;
      id2 = id;
    } else {
      //print("resss" + response.reasonPhrase.toString());
    }
  }

  Future acti() async {
    print('jojojo' + id2.toString());
    print('ksksks' + item_count1.toString());
    List val = [];
    List valeu = [];
    List<String> m = [];
    List valu = [];
    List<bool> valuB = [];
    var headers = {'X-Authorization': tokens};
    print("item_count1" + item_count1.toString());
    for (int z = 0; z < item_count1; z++) {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
                  id2[z] +
                  '/values/attributes/CLIENT_SCOPE'

              /*'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
                  id2[z] +
                  '/values/attributes/CLIENT_SCOPE'*/
              ));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("0");

        String res = await response.stream.bytesToString();
        print("1");
        List body = json.decode(res);
        print("2" + body.toString());

        print('actiiiii' + body.toString());
        print(body.runtimeType);
        print(body.length);
        val.addAll(body);
        for (int q = 0; q < body.length; q++) {
          m.add(val[q]["key"]);
          valu.add(val[q]["value"]);
        }

        print(m);
        print(valu);

        //_flutter = val;
        //Map<String, dynamic> values = await json.decode(body.toString());
        print("3");

        print("4");
        var y = (body.toString());
        print(y);
      } else {
        print("ress" + response.reasonPhrase.toString());
      }
    }
    print('list5' + m.toString());

    print(valu);
    nom = m;
    convBool();
  }

  Future dev() async {
    List kol = [];
    List kol1 = [];
    List cle = [];
    final val = Map<String, dynamic>();
    List valeu = [];
    var headers = {'X-Authorization': tokens};
    for (int j = 0; j < item_count1; j++) {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
                  id2[j] +
                  '/values/timeseries?useStrictDataTypes=false'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
//        print("0");

        String res = await response.stream.bytesToString();
        //print("1");
        Map<String, dynamic> body = json.decode(res);
        //print("2" + body.toString());

        cle.add(body.keys);

        val.addAll(body);
        print("3laah" + val.values.runtimeType.toString());
        kol.addAll(val.values..toString());
        kol1.addAll(val.keys..toString());
        print("3laah1" + kol1.toString());
        print("3laah2" + kol.toString());
        //  print('devvvv' + val.keys.toString());
      } else {
        print("resss" + response.reasonPhrase.toString());
      }
    }
    for (int k = 0; k < kol.length; k++) {
      valeu.add(kol[k][0]["value"]);
    }
    int real = valeu.length;
    valeurr = valeu;
    clee = kol1;
    print("tesssst");
    print(real);
    print(valeu);
    print(kol1);
    vall = real;
    v2 = Snapshot.fromJson(valeurr);
  }

  Future apps(int x, bool z) async {
    setState(() {
      valuer[x] = z;
    });
  }

  convBool() {
    int bo = 0;

    while (bo < vall1) {
      print('cbcb');
      print(valu[bo].toLowerCase());
      if (valu[bo].toLowerCase() == 'false') {
        print('gggg');
        valuer.add(false);
        print('ffffff');
      } else {
        print('lllllll');
        valuer.add(true);
      }
      bo++;
    }
    print('convertttt');
    print(valuer[0].runtimeType);
  }
}
