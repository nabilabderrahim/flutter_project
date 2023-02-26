import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:version1/page/login.dart';
import 'package:version1/view/loading.dart';
import '../api.dart';
import 'Devices.dart';
import 'Home.dart';

class Customers extends StatefulWidget {
  @override
  State<Customers> createState() => _CustomersState();
}

bool loading = false;
TextEditingController editingController = TextEditingController();
List<String> name = [];
List<String> filteredList = [];
int itemcount = 0;
String idCus = idoo[0];
int itC = item_count;
List<String> name1 = [];
List description = [];

final duplicateItems =
    List<String>.generate(item_count, (index) => namee[index]);

class _CustomersState extends State<Customers> {
  @override
  void initState() {
    print("logggin" + loginCtl.text);
    print("logggin" + pwdCtl.text);
    see();
    super.initState();
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
      itC = dummyListData.length;
      setState(() {
        namee.clear();
        namee.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        namee.clear();
        namee.addAll(duplicateItems);
        itC = item_count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (itC == 0) {
      return const Loading();
    }
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Customers"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Container(
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
                        itemCount: itC,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Color.fromRGBO(250, 247, 255, 1.0),
                            child: ListTile(
                                textColor: Colors.black54,
                                leading: Icon(
                                    Icons.supervised_user_circle_outlined,
                                    color: Color(0xFF527DAA)),
                                trailing: ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromRGBO(
                                                    250, 247, 255, 1.0))),
                                    onPressed: () async {
                                      await vee(index);
                                      Navigator.pushNamed(context, '/Sites',
                                          arguments: {
                                            idCus,
                                          });
                                    },
                                    icon: Icon(Icons.chevron_right,
                                        color: Color(0xFF527DAA)),
                                    label: Text("")),
                                subtitle: Text(email[index].toString()),
                                title: Text(namee[index])),
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
                    label: ('Notification'),
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

  Future site(String idf) async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/customer/' +
            idf +
            '/assetInfos?pageSize=10&page=0'));

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
      itemcount = y;
      List<String> namme = [];
      List desc = [];
      print("Nbre Elements : " + y.toString());
      for (int i = 0; i < y; i++) {
        var x = body["data"][i]["additionalInfo"]["description"];
        var z = body["data"][i]["name"];
        namme.add(z);
        desc.add(x);
      }
      description = desc;
      name1 = namme;
      print(desc);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  see() async {
    super.initState();
    await gettoken();
    // await filC();
    setState(() {
      print(itemcount);
      idCus = '';
      site(idCus);
    });

    name.addAll(duplicateItems);
  }

  vee(int j) {
    idCus = idoo[j];
    site(idCus);
  }
}
