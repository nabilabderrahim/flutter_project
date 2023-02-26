import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:version1/page/Node.dart';
import 'dart:convert' show json, jsonDecode, JSON;
import '../api.dart';
import '../view/loading.dart';
import 'test.dart';

class Actuator extends StatefulWidget {
  @override
  State<Actuator> createState() => _ActuatorState();
}

String postNom2 = '';
bool postValue2 = true;
TextEditingController editingController = TextEditingController();
int itA = item_count1;

List<String> filteredList = [];
bool loading = false;
final duplicateItems =
    List<String>.generate(item_count1, (index) => nom[index]);

class _ActuatorState extends State<Actuator> {
  rt() {
    itA = item_count1;
  }

  rte() async {
    await rt();
    print(itA);
    nom.addAll(duplicateItems);
    super.initState();
  }

  void initState() {
    print("nono" + nom.toString());
    print(valuer[0].runtimeType);

    rte();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((nom) {
        if (nom.contains(query)) {
          dummyListData.add(nom);
        }
      });
      itA = dummyListData.length;
      setState(() {
        nom.clear();
        nom.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        nom.clear();
        nom.addAll(duplicateItems);
        itA = item_count1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Actuator"),
              centerTitle: true,
              backgroundColor: Colors.blue,
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
                    itemCount: itA,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        child: SwitchListTile(
                          title: Text(
                            nom[index],
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
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
                            postValue2 = valuer[index];
                            postNom2 = nom[index].toString();
                            print('fele5er $postNom2 = $postValue2');
                            postData();
                          },
                          secondary: Icon(Icons.opacity),
                          subtitle: Text(
                            valuer[index].toString(),
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      );
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

  void postData() async {
    print('4444' + postValue2.toString());
    print(idNod);

    var headers = {
      'X-Authorization': tokens,
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://91.134.146.229:19999/api/plugins/rpc/twoway/' + idNod));
    request.body = json.encode({
      "method": "data",
      "params": {
        "method": "setGpioStatus",
        "params": {"pin": postNom2, "enabled": postValue2}
      },
      "timeout": "500"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(postValue2);
      print("jjj" + await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future apps(int x, bool z) async {
    setState(() {
      valuer[x] = z;
    });
  }
}
