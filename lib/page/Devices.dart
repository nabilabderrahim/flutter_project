import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:version1/api.dart';
import 'dart:convert' show json, jsonDecode;

import '../view/loading.dart';

class Devices extends StatefulWidget {
  @override
  State<Devices> createState() => _DevicesState();
}

int item_count = 1;
int item_count1 = 1;
int item_count2 = 1;
List idoo = [];
int vall = 1;
List id2 = [];
List valeurr = [];
List clee = [];
List nom = [];
List valuer = [];
bool loading = false;
List<String> namee = [];
List email = [];

class _DevicesState extends State<Devices> {
  @override
  void initState() {
    dee();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Active"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Customers',
                          arguments: {namee, email, item_count, idoo},
                        );
                      },
                      color: Color.fromRGBO(250, 247, 255, 1.0),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListTile(
                          leading: Icon(Icons.supervised_user_circle_outlined,
                              color: Color(0xFF527DAA)),
                          trailing: Icon(Icons.chevron_right,
                              color: Color(0xFF527DAA)),
                          title: Text(
                            "Customers",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  /* Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/monitoring', arguments: {
                          id2,
                          item_count2,
                          item_count1,
                          vall,
                          clee,
                          valuer,
                          valeurr,
                          nom
                        });
                      },
                      color: Color.fromRGBO(250, 247, 255, 1.0),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListTile(
                          hoverColor: Colors.redAccent,
                          textColor: Colors.black54,
                          leading: Icon(Icons.fiber_new_rounded,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          trailing: Icon(Icons.chevron_right,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          title: Text(
                            "Live Monitoring",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),*/
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

  Future customer() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/customers?pageSize=10&page=0'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());

      // Map<String, dynamic> values = await json.decode(body);
      print("3");

      print("4");
      int y = int.parse(body["totalElements"].toString());
      item_count = y;
      List<String> name1 = [];
      List<String> ido1 = [];
      List email1 = [];
      for (int i = 0; i < item_count; i++) {
        var named = body["data"][i]["name"];
        var mail = body["data"][i]["email"];
        var ido = body["data"][i]["id"]["id"];
        ido1.add(ido);
        name1.add(named);
        email1.add(mail);
      }
      print(name1);
      print("roberto" + ido1.toString());
      print("Nbre Elements : " + y.toString());
      namee = name1;
      email = email1;
      idoo = ido1;
      print(email1);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future idd() async {
    print("bac" + idoo.length.toString());
    var headers = {'X-Authorization': tokens};
    final valDev = Map<dynamic, dynamic>();
    for (int y = 0; y < idoo.length; y++) {
      var request = http.Request(
          'GET',
          Uri.parse('http://91.134.146.229:19999/api/customer/' +
              idoo[y] +
              '/deviceInfos?pageSize=10&page=0'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("0");

        String res = await response.stream.bytesToString();
        print("1");
        Map<String, dynamic> body = json.decode(res);
        print("2" + body.toString());
        valDev.addAll(body);
        List<String> id = [];
        int totl = int.parse(valDev["totalElements"].toString());
        print("toooot" + totl.toString());
        //print((valDev.values).toList()[0][i]['id']['id']);
        for (int i = 0; i < totl; i++) {
          if (((body.values.toList())[2]) == 0) {
            i++;
          }
          print('www' + valDev.values.toList()[0].runtimeType.toString());
          print(('wswsws' + valDev.values.toList()[0].toString()));
          //id.addAll((body.values.toList())[0][i]['id']..toString());
          //  id2 = id;
        }
        print("skander" + id.toString());
        item_count1 = totl;
        //  id2 = id;
        print("skander1" + id2.toString());
      } else {
        print("resss" + response.reasonPhrase.toString());
      }
    }
    print('terminal' + id2.toString());
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
        kol.addAll(val.values..toString());
        kol1.addAll(val.keys..toString());
        //  print('devvvv' + val.keys.toString());
      } else {
        print("resss" + response.reasonPhrase.toString());
      }
    }

    //print('mmm' + ke.toString());
    // print('koko' + jj.toString());
    //print("debut" + kol.toString());
    //print("debut" + kol1.toString());
    //print(kol.runtimeType);
    //print(kol.length);
    //print("cleeeee" + cle.toString());

    //print(cle.length);
    //print("itemmmm" + item_count.toString());
    //print("valleurrrr" + jj[0][0]["value"].toString());
    for (int k = 0; k < kol.length; k++) {
      valeu.add(kol[k][0]["value"]);
    }
    // print("hoohoh" + valeu.toString());
    // print("ohohoh" + kol1.toString());
    int real = valeu.length;
    valeurr = valeu;
    clee = kol1;
    print("tesssst");
    print(real);
    print(valeu);
    print(kol1);
    vall = real;
  }

  /*Future dev() async {
    List kol = [];
    List cle = [];
    final val = Map<String, dynamic>();
    List valeu = [];
    print("ttt" + idoo.length.toString());
    var headers = {'X-Authorization': tokens};
    for (int j = 0; j < idoo.length; j++) {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
                  idoo[j] +
                  '/values/timeseries?useStrictDataTypes=false'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("0");

        String res = await response.stream.bytesToString();
        print("1");
        Map<String, dynamic> body = json.decode(res);
        print("2" + body.toString());
        kol.add(body.toString());
        cle.add(body.keys);

        val.addAll(body);
        print('devvvv' + body.toString());
      } else {
        print("resss" + response.reasonPhrase.toString());
      }
    }

    List ke = val.keys.toList();
    List jj = val.values.toList();
    print('mmm' + ke.toString());
    print('koko' + jj.toString());
    print("debut" + kol.toString());
    print("cleeeee" + cle.toString());
    print(cle.length);
    //print("itemmmm" + item_count1.toString());
    //print("valleurrrr" + jj[0][0]["value"].toString());
    for (int k = 0; k < 5; k++) {
      valeu.add(jj[k][0]["value"]);
    }
    print("hoohoh" + valeu.toString());
    print("ohohoh" + ke.toString());
    int real = valeu.length;
    valeurr = valeu;
    clee = ke;
    print(real);
    vall = real;
  }*/

  Future acti() async {
    print('jojojo' + id2.toString());
    print('ksksks' + item_count1.toString());
    final val = Map<String, dynamic>();
    List valeu = [];
    var headers = {'X-Authorization': tokens};
    for (int z = 0; z < item_count1; z++) {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/5836ae00-bfbf-11ec-8ea2-c70cb76c1d8e/values/attributes/CLIENT_SCOPE'

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
        print(body.runtimeType);
        item_count2 = body.length;
        List<String> m = [];
        List valu = [];
        for (int i = 0; i < body.length; i++) {
          m.add(body[i]["key"]);
          valu.add(body[i]["value"]);
        }
        print('list' + m.toString());

        print(valu);
        nom = m;
        valuer = valu;
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
  }

  dee() async {
    await gettoken();
    await customer();
    await idd();
    await dev();
    // await acti();
    //  super.initState();
  }
}
