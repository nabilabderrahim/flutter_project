import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;
import '../api.dart';
import '../view/loading.dart';

class Sensor extends StatefulWidget {
  const Sensor({Key? key}) : super(key: key);

  @override
  State<Sensor> createState() => _SensorState();
}

int item_count = 1;
String name = "";
String id1 = "";
String acces_token = "";
List<String> namee = [];
TextEditingController editingController = TextEditingController();

List<String> filteredList = [];
bool loading = false;
final duplicateItems =
    List<String>.generate(item_count, (index) => namee[index]);

class _SensorState extends State<Sensor> {
  deb() async {
    await gettoken();
    await idd();
    await tookens();
    await sensor();
    setState(() {
      sensor();
      idd();
      tookens();
    });
    namee.addAll(duplicateItems);
    super.initState();
  }

  void initState() {
    deb();
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
      setState(() {
        namee.clear();
        namee.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        namee.clear();
        namee.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sensor"),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Container(
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
                    itemCount: item_count,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: Color.fromRGBO(250, 247, 255, 1.0),
                          child: ListTile(
                            textColor: Colors.black54,
                            leading: Icon(Icons.sensors,
                                color: Color.fromRGBO(210, 124, 44, 1.0)),
                            trailing: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Color.fromRGBO(250, 247, 255, 1.0))),
                                onPressed: () {
                                  // tookens();
                                  Navigator.pushNamed(
                                    context,
                                    '/dash',
                                  );
                                  // idd();
                                  setState(() {});
                                },
                                icon: Icon(Icons.chevron_right,
                                    color: Color.fromRGBO(210, 124, 44, 1.0)),
                                label: Text("")),
                            subtitle: Text(DateTime.now().toString()),
                            /*Icon(Icons.chevron_right,
                      color: Color.fromRGBO(210, 124, 44, 1.0)),*/
                            // title: Text(l[index])),
                            title: Text(namee[index]),
                          ));
                    }),
              )
            ])),
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

  Future sensor() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/customer/88d344b0-af34-11ec-8ea2-c70cb76c1d8e/deviceInfos?pageSize=10&page=0'));

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
      int y = int.parse(body["totalElements"].toString());
      List<String> tr = [];
      var named = body["data"][0]["name"].toString();
      name = named;
      for (int i = 0; i < item_count; i++) {
        var named = body["data"][i]["name"].toString();
        var idd = body["data"][i]["id"]["id"].toString();
        tr.add(named);
      }
      print("iddd:" + tr.toString());
      item_count = y;
      namee = tr;
      print("Lisssst" + tr.toString());
      print("Nbre Elements : " + y.toString());
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future tookens() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request('GET',
        Uri.parse('http://91.134.146.229:19999/api/device/$id1/credentials'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());

      var y = body.toString();
      var tk = body["credentialsId"].toString();
      acces_token = tk;
      print(y);
      print("Access Token:" + tk);
    } else {
      print("ress" + response.reasonPhrase.toString());
    }
  }

  Future idd() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/$id1/values/timeseries?useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());

      List y = body.keys.toList();
      var te = y[0];

      print("skander" + y.toString());
      print("bilel" + te);
    } else {
      print("resss" + response.reasonPhrase.toString());
    }
  }
}
