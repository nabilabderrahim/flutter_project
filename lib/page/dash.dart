import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snapshot/snapshot.dart';
import 'package:version1/page/Node.dart';
import 'package:version1/page/test.dart';
import 'dart:convert' show json, jsonDecode;
import '../api.dart';

import 'Dashboard.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

String valD = '';
String nameD = "";
String value = "";
List valuee = [];
Snapshot v1 = [] as Snapshot;
List valTe = [];

List temps = [];
List valTe1 = [];
List temps1 = [];

int In1 = 1648026660396;
int Out1 = DateTime.now().millisecondsSinceEpoch;
int Inn = 0;
int Outt = 0;
int In2 = 1648026660396;
int ind = 1;
int itD = item_count2;
int Out2 = DateTime.now().millisecondsSinceEpoch;

TextEditingController editingController = TextEditingController();
List<String> filteredList = [];
final duplicateItems =
    List<String>.generate(item_count2, (index) => dev[index]);
bool loading = false;

class _DashState extends State<Dash> {
  deb() async {
    await gettoken();
    await getdata();
    await test4();
    await test5();
    dev.addAll(duplicateItems);
    super.initState();
  }

  void initState() {
    print("item_count2" + item_count2.toString());
    getdata();
    test5();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      itD = dummyListData.length;
      setState(() {
        dev.clear();
        dev.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        dev.clear();
        dev.addAll(duplicateItems);
        itD = item_count2;
      });
    }
  }

  tee() async {
    await getdata();
    await getSensor();
    await test4();
    test5();
    valTe1;
    temps1;
  }

  final bool _running = true;
  Stream<String> _clock() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 10));
      setState(() {
        dev1;
        test5();
      });

      getdata();
      getSensor();
      tee();
      Dash();
      Out1 = DateTime.now().millisecondsSinceEpoch;
      Out2 = DateTime.now().millisecondsSinceEpoch;
    }
  }

  @override
  Widget build(BuildContext context) {
    veein(int j) {
      ind = j;
      vee(j);
      test4();
      test5();
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: Text("Sensor"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: item_count2 == 0
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Center(
              child: StreamBuilder(
                  stream: _clock(),
                  builder: (context, v1) {
                    return Container(
                        child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          onChanged: (valuee) {
                            filterSearchResults(valuee);
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            itemCount: item_count2,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Color.fromRGBO(250, 247, 255, 1.0),
                                child: ListTile(
                                    textColor: Colors.black54,
                                    leading: Icon(
                                      Icons.opacity,
                                      semanticLabel: ("Valeur"),
                                      color: Color.fromRGBO(210, 124, 44, 1.0),
                                    ),
                                    trailing: ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(Color.fromRGBO(
                                                        250, 247, 255, 1.0))),
                                        onPressed: () async {
                                          ind = index;
                                          await vee(index);
                                          await test5();
                                          veein(index);
                                          Navigator.pushReplacementNamed(
                                              context, '/dashboard',
                                              arguments: {
                                                getdata(),
                                                test4(),
                                                test5(),
                                                getdata(),
                                                nameD,
                                                value,
                                                valTe,
                                                valTe1,
                                                ind,
                                                temps,
                                                temps1,
                                                In1,
                                                Out1,
                                                Inn,
                                                Outt,
                                                In2,
                                                Out2,
                                                valD,
                                                dev,
                                                idNod
                                              });
                                        },
                                        icon: Icon(Icons.chevron_right,
                                            color: Color.fromRGBO(
                                                210, 124, 44, 1.0)),
                                        label: Text("")),
                                    subtitle: Text(
                                        dev1[index][0]["value"] + "\u00B0"),
                                    title: Text(dev[index])),
                              );
                            }),
                      )
                    ]));
                  })),
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
                color: Color.fromRGBO(126, 184, 234, 1),
                icon: Icon(Icons.supervised_user_circle, color: Colors.white),
              ),
              label: ('Profile'),
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  Future getdata() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      List y = body.keys.toList();
      List caal = [];
      int n = y.length;
      List val = body.values.toList();
      for (int f = 0; f < n; f++) {
        caal.add(val[f][0]["value"]);
      }
      valuee = caal;
      v1 = Snapshot.fromJson(valuee);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
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
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      List<String> y = body.keys.toList();
      int n = y.length;
      dev = y;
      var te = y[0];
      title = te;

      item_count2 = n;
      sensor = te;
      List val = body.values.toList();
      dev1 = val;
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future test4() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=' +
            nameD +
            '&startTs=$In1&endTs=$Out1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());
      print("3");

      print("4");
      var y = (body.toString());
      List z = y.split("humidity");
      List valT = [];
      List temp = [];
      for (int i = 0; i < 10; i++) {
        valT.add(body["$nameD"][i]["value"]);
        temp.add(body["$nameD"][i]["ts"]);
      }
      print("Nbre Elements : " + y.toString());
      print(y.length);
      print(valT);
      print(temp);
      temps = temp;
      valTe = valT;
      int outt = 0;
      outt = Out1;
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future test5() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=' +
            nameD +
            '&startTs=$In2&endTs=$Out2'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      var y = (body.toString());
      List valT1 = [];
      List temp1 = [];
      for (int i = 0; i < 10; i++) {
        valT1.add(body["$nameD"][i]["value"]);
        temp1.add(body["$nameD"][i]["ts"]);
      }
      temps1 = temp1;
      valTe1 = valT1;
      for (int j = 0; j < 10; j++) {
        chartData.add(ChartData(
            DateTime.fromMillisecondsSinceEpoch(temps1[j]).toString(),
            double.parse(valTe1[j])));
      }
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  vee(int j) {
    valD = valuee[j];
    nameD = dev[j];
  }
}
