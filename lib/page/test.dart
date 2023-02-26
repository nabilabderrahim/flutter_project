import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;

import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

import '../api.dart';
import '../view/loading.dart';
import 'Node.dart';
import 'Sensor.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

String title = name;
List valu = [];
int item_count2 = 0;
String sensor = "";
List<String> dev = [];
List dev1 = [];
int item_count1 = 0;

List<String> nom = [];
List valuer = [];
bool loading = false;

class _TestState extends State<Test> {
  deb() async {
    await gettoken();
    getSensor();
    getActuator();
    super.initState();
  }

  void initState() {
    deb();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(nomNod),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(234, 239, 237, 1.0)),
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        print("dev1" + dev.toString());
                        Navigator.pushReplacementNamed(context, '/dash',
                            arguments: {
                              item_count2,
                              sensor,
                              title,
                              dev,
                              dev1,
                              idNod,
                              getSensor()
                            });
                      },
                      color: Color.fromRGBO(250, 247, 255, 1.0),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListTile(
                          hoverColor: Colors.redAccent,
                          textColor: Colors.black54,
                          leading: Icon(Icons.sensors,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          trailing: Icon(Icons.chevron_right,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          title: Text(
                            "Sensor",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/actuator',
                            arguments: {nom, valuer, item_count1});
                      },
                      color: Color.fromRGBO(250, 247, 255, 1.0),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListTile(
                          hoverColor: Colors.redAccent,
                          textColor: Colors.black54,
                          leading: Icon(Icons.precision_manufacturing_outlined,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          trailing: Icon(Icons.chevron_right,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          title: Text(
                            "Actuator",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Automatique',
                            arguments: {
                              idNod,
                            });
                      },
                      color: Color.fromRGBO(250, 247, 255, 1.0),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListTile(
                          hoverColor: Colors.redAccent,
                          textColor: Colors.black54,
                          leading: Icon(Icons.precision_manufacturing_outlined,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          trailing: Icon(Icons.chevron_right,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          title: Text(
                            "Automatique",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                ],
              ),
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

  Future getSensor() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2780." + body.toString());

      List<String> y = body.keys.toList();

      int n = y.length;
      dev = y;
      var te = y[0];
      title = te;

      item_count2 = n;
      sensor = te;
      List val = body.values.toList();
      dev1 = val;

      //    print("valeur" + vale.toString());
      print("y" + y.toString());
      print(n);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future getActuator() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/attributes/CLIENT_SCOPE'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      List body = json.decode(res);
      print("2" + body.toString());
      print(body.runtimeType);
      print(body.length);
      List<String> m = [];

      for (int i = 0; i < body.length; i++) {
        m.add(body[i]["key"]);
        valu.add(body[i]["value"]);
      }
      print('listt' + m.toString());
      for (int h = 0; h < body.length; h++) {
        print(valu[h].runtimeType);
      }

      print(valu);
      nom = m;
      convBool();
      item_count1 = body.length;
      print("3");

      print("4");
      var y = (body.toString());
      print(y);
    } else {
      print("ress" + response.reasonPhrase.toString());
    }
  }

  convBool() {
    int bo = 0;

    while (bo < valu.length) {
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
