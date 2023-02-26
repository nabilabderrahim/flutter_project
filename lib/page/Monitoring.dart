import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:convert' show json, jsonDecode;
import '../api.dart';

import '../view/loading.dart';
import 'Devices.dart';

class Monitoring extends StatefulWidget {
  const Monitoring({Key? key}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}

//int item_count2 = 1;
//int vall = 1;
//int item_count1 = 1;
List<String> namee = [];
//List id2 = [];
//List valeurr = [];
//List clee = [];
String cd = '';
//List nom = [];
//List valuer = [];
String postNom = '';
bool postValue1 = true;

class _MonitoringState extends State<Monitoring> {
  /* rez() async {
    await gettoken();
    await idd();
    await dev();
    await acti();
  }*/

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Monitoring"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: ListView(scrollDirection: Axis.vertical, children: [
              GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // Número de elementos del eje horizontal.
                      crossAxisCount: 2,
                      // Espaciado vertical del eje
                      mainAxisSpacing: 25.0,
                      // Espaciado horizontal del eje
                      crossAxisSpacing: 10.0,
                      // La relación de ancho, alto y largo de subcomponentes
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    {
                      double _volumeValue = double.parse(valeurr[index]);

                      fct(index);
                      return Column(
                        children: <Widget>[
                          Container(
                            color: RandomColorModel().getColor(),
                            padding: EdgeInsets.all(9),
                            height: 175,
                            width: 175,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 120,
                                  width: 120,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: 0,
                                        maximum: 100,
                                        showLabels: false,
                                        showTicks: false,
                                        radiusFactor: 0.7,
                                        axisLineStyle: AxisLineStyle(
                                            color: Colors.black12,
                                            thickness: 5),
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                              value: _volumeValue,
                                              width: 5,
                                              sizeUnit:
                                                  GaugeSizeUnit.logicalPixel,
                                              gradient: const SweepGradient(
                                                  colors: <Color>[
                                                    Color(0xFFCC2B5E),
                                                    Color(0xFF753A88)
                                                  ],
                                                  stops: <double>[
                                                    0.25,
                                                    0.75
                                                  ])),
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              angle: 90,
                                              axisValue: 5,
                                              positionFactor: 0.2,
                                              widget: Text(
                                                  _volumeValue
                                                          .ceil()
                                                          .toString() +
                                                      cd,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Color(0xFFCC2B5E))))
                                        ])
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    clee[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
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
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: item_count2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // Número de elementos del eje horizontal.
                      crossAxisCount: 2,
                      // Espaciado vertical del eje
                      mainAxisSpacing: 25.0,
                      // Espaciado horizontal del eje
                      crossAxisSpacing: 10.0,
                      // La relación de ancho, alto y largo de subcomponentes
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    {
                      double _volumeValue = double.parse(valeurr[index]);

                      fct(index);
                      return Column(children: <Widget>[
                        Container(
                          color: RandomColorModel().getColor(),
                          padding: EdgeInsets.only(left: 1),
                          height: 100,
                          width: 250,
                          child: Container(
                            child: SwitchListTile(
                              title: Text(
                                nom[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18),
                              ),
                              value: valuer[index],
                              activeColor: Colors.red,
                              inactiveTrackColor: Colors.grey,
                              onChanged: (bool value) async {
                                await apps(index, value);
                                print('kkkk' + value.toString());
                                print(valuer);
                                print(nom);
                                print(index);
                                postValue1 = valuer[index];
                                postNom = nom[index].toString();
                                print('fele5er $postNom = $postValue1');
                                postData();
                              },
                              subtitle: Text(
                                valuer[index].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18),
                              ),
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          ),
                        )
                      ]);
                    }
                  }),
            ]),
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
        'X-Authorization': '$token'
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

  Future apps(int x, bool z) async {
    setState(() {
      valuer[x] = z;
    });
  }
}

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}
