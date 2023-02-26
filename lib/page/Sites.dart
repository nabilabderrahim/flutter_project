import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:snapshot/snapshot.dart';
import 'package:version1/page/Customers.dart';
import 'dart:convert' show json, jsonDecode;

import '../api.dart';
import '../view/loading.dart';

class Sites extends StatefulWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  State<Sites> createState() => _SitesState();
}

List valu = [];
List<bool> valuB = [];
List idN = [];
int item_count = 1;
List<String> name = [];
int item_count2 = 1;
int vall = 0;
int vall1 = 0;
int item_count1 = 1;
List id2 = [];
List valeurr = [];
List clee = [];
List<bool> valuer = [];
List nom = [];

class _SitesState extends State<Sites> {
  deb() async {
    await gettoken();
    await node();
    await idd();
    dev();
    acti();
    super.initState();
  }

  @override
  void initState() {
    deb();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              leading: new Container(),
              title: Text("Sites"),
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
                        Navigator.pushNamed(context, '/Monitoring_Site',
                            arguments: {
                              item_count1,
                              item_count2,
                              id2,
                              clee,
                              valeurr,
                              vall,
                              nom,
                              valuer,
                              vall1
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
                            "Live Monitoring",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Node',
                            arguments: {item_count, name, idN});
                        print("rrr" + idN.toString());
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
                            "Node",
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

  Future idd() async {
    print('iddii');
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/customer/' +
            idCustomer +
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
          valu.add((val[q]["value"]));
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
    vall1 = valu.length;
    print('chbiik' + valu[0].runtimeType.toString());

    print(vall1);
    nom = m;
    print('nhy');
    convBool();

    print('llll' + valuer[0].runtimeType.toString());
  }

  Future dev() async {
    List kol = [];
    List kol1 = [];
    List cle = [];

    List valeu = [];
    print("tesssssst" + item_count1.toString());
    var headers = {'X-Authorization': tokens};
    for (int j = 0; j < item_count1; j++) {
      final val = Map<String, dynamic>();
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
        kol.addAll(val.values);
        print(val.keys);
        print(val.length);

        kol1.addAll(val.keys);
        print("3laah1" + kol1.toString());
        print("3laah2" + kol.toString());
        //  val=[];
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
    print(vall);
  }

  Future node() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/customer/' +
            idCustomer +
            '/deviceInfos?pageSize=10&page=0'));

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
      List<String> naml = [];
      print("Nbre Elements : " + y.toString());
      for (int i = 0; i < y; i++) {
        //  var x = body["data"][i]["additionalInfo"]["description"];
        var z = body["data"][i]["name"];
        var k = body["data"][i]["id"]["id"];
        naml.add(z);
        idN.add(k);
        print("name:" + z.toString());
        // print("Description : " + x.toString());
      }
      print(idN);
      print('ff' + naml.toString());
      name = naml;
      //  return (x);

    } else {
      print("ress" + response.reasonPhrase.toString());
    }
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
    print(valuer.length);
  }
}

/*  Future actt() async {
    List kol = [];
    List kol1 = [];
    List cle = [];
    List val = [];
    List valeu = [];
    print(item_count1);
    var headers = {'X-Authorization': tokens};
    for (int j = 0; j < item_count1; j++) {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
                  id2[j] +
                  '/values/attributes/CLIENT_SCOPE'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("0");

        String res = await response.stream.bytesToString();
        print("1");
        List body = json.decode(res);
        print("2" + body.toString());

//        cle.add(body.keys);
        print('valllll');
        print(body.length);
        val.addAll(body);
        print('valllll5' + val.toString());
        for (int q = 0; q < body.length; q++) {
          kol1.add(val[q]["key"]);
          kol.add(val[q]["value"]);
        }

//        kol.addAll(val[key].toString());
        //      kol1.addAll(val.keys..toString());
        //    print('devvvv' + val.keys.toString());
      } else {
        print("resss" + response.reasonPhrase.toString());
      }
      print("kllll" + kol1.toString());
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
      // valeu.add(kol[k][0]["value"]);
    }
    print("hoohoh" + kol.toString());
    print("ohohoh" + kol1.toString());
    int real = kol.length;
    print(real);
    valuer = kol;
    nom = kol1;
    //print("tesssst");
    //print(real);
    //print(valeu);
    //print(kol1);
    item_count2 = real;
  }
*/
