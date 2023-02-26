import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;

import 'package:version1/page/auto.dart';

int itemCount = 1;
List<String> namee = [];
List<dynamic> id = [];
int k = 5;
TextEditingController editingController = TextEditingController();
final duplicateItems =
    List<String>.generate(itemCount, (index) => namee[index]);

class ListCronicle extends StatefulWidget {
  const ListCronicle({Key? key}) : super(key: key);

  @override
  State<ListCronicle> createState() => _ListCronicleState();
}

class _ListCronicleState extends State<ListCronicle> {
  @override
  void initState() {
    see1();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((namee) {
        if (namee.contains(query)) {
          dummyListData.add(namee);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("List Jobs"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: itemCount == 0
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Container(
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
                    itemCount: itemCount, //itemCount
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color.fromRGBO(250, 247, 255, 1.0),
                        child: ListTile(
                            textColor: Colors.black54,
                            leading: Icon(Icons.wb_auto,
                                color: Color.fromRGBO(8, 229, 221, 1.0)),
                            trailing: Column(
                              children: [
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromRGBO(
                                                    245, 90, 128, 1.0))),
                                    onPressed: () async {
                                      await DeleteCr(index);
                                      Navigator.pushNamed(context, '/Cronicle');

                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete,
                                        color:
                                            Color.fromRGBO(8, 229, 221, 1.0)),
                                    label: Text("")),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text("ID:  " + id[index] + '   '),
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromRGBO(
                                                    250, 247, 255, 0.8))),
                                    onPressed: () async {
                                      k = index;
                                      Navigator.pushNamed(context, '/Yearly',
                                          arguments: {id[index], k});

                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove_red_eye_outlined,
                                        color:
                                            Color.fromRGBO(8, 229, 221, 1.0)),
                                    label: Text("")),
                              ],
                            ),
                            title: Text("TITLE:  " + namee[index])),
                      );
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    //personnel.clear();
                    // titleController.text = '';
                    Navigator.pushNamed(context, '/Automatique');
                  },
                  child: Text("Add New Event"))
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
                icon: Icon(Icons.supervised_user_circle, color: Colors.white),
              ),
              label: ('Profile'),
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  Future getSch() async {
    var headers = {'X-API-Key': '\t1ba1014d3850edbea399c202d779482a'};
    var request = http.Request('GET',
        Uri.parse('http://91.134.146.229:30012/api/app/get_schedule/v1'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2");
      //  print(body.toString());
      print('3');
      List<String> named1 = [];
      List id1 = [];
      print(body["rows"][0]["title"]);
      print(body["rows"][0]["id"]);
      print(body["list"]["length"]);
      itemCount = body["list"]["length"];
      for (int i = 0; i < itemCount; i++) {
        var named = body["rows"][i]["title"];
        var idd = body["rows"][i]["id"];
        named1.add(named);
        id1.add((idd));
      }
      print(named1);
      print(id1);
      namee = named1;
      id = id1;

      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  see1() async {
    await getSch();
    setState(() {
      //() async => {await site()};

      getSch();
    });

    namee.addAll(duplicateItems);
    super.initState();
  }

  Future DeleteCr(int k) async {
    var headers = {
      'X-API-Key': '1ba1014d3850edbea399c202d779482a',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('http://91.134.146.229:30012/api/app/delete_event/v1'));
    request.body = json.encode({"id": id[k]});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
