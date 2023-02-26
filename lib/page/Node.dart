import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:version1/view/loading.dart';
import 'dart:convert' show json, jsonDecode;
import 'Sites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../api.dart';

class Node extends StatefulWidget {
  @override
  State<Node> createState() => _NodeState();
}

bool loading = false;
String idNod = '';
String nomNod = '';
int itN = item_count;
TextEditingController editingController = TextEditingController();
List<String> filteredList = [];
final duplicateItems =
    List<String>.generate(item_count, (index) => name[index]);

class _NodeState extends State<Node> {
  deb() async {
    print("ityem" + item_count.toString());
    itN = item_count;
    await gettoken();
    name.addAll(duplicateItems);
    super.initState();
  }

  @override
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
      itN = dummyListData.length;
      setState(() {
        name.clear();
        name.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        name.clear();
        name.addAll(duplicateItems);
        itN = item_count;
      });
    }
  }

  final bool _running = true;
  Stream<String> _clock() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 10));
      setState(() {});
    }
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
              title: Text("Node"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: itN == 0
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)))),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  itemCount: itN,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: Color.fromRGBO(250, 247, 255, 1.0),
                                      child: ListTile(
                                          textColor: Colors.black54,
                                          leading:
                                              Icon(Icons.supervised_user_circle_outlined,
                                                  color: Color.fromRGBO(
                                                      210, 124, 44, 1.0)),
                                          trailing: ElevatedButton.icon(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          Color.fromRGBO(250,
                                                              247, 255, 1.0))),
                                              onPressed: () async {
                                                await vee(index);
                                                // customer();
                                                Navigator.pushNamed(
                                                    context, '/test',
                                                    arguments: {idNod, nomNod});

                                                setState(() {});
                                              },
                                              icon: Icon(Icons.chevron_right,
                                                  color: Color.fromRGBO(
                                                      210, 124, 44, 1.0)),
                                              label: Text("")),
                                          subtitle:
                                              Text(DateTime.now().toString()),
                                          /*Icon(Icons.chevron_right,
                      color: Color.fromRGBO(210, 124, 44, 1.0)),*/
                                          title: Text(name[index])),
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

  vee(int j) {
    idNod = idN[j];
    nomNod = name[j];
  }
}
