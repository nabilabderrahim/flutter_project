import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;
import '../api.dart';

class Monthly extends StatefulWidget {
  const Monthly({Key? key}) : super(key: key);

  @override
  State<Monthly> createState() => _MonthlyState();
}

int item_count = 1;
List idoo = [];
List<String> namee = [];
List email = [];
bool isLoading = true;

class _MonthlyState extends State<Monthly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              child: Column(children: <Widget>[
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  itemCount: item_count,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Color.fromRGBO(250, 247, 255, 1.0),
                      child: ListTile(
                          textColor: Colors.black54,
                          leading: Icon(Icons.supervised_user_circle_outlined,
                              color: Color.fromRGBO(210, 124, 44, 1.0)),
                          trailing: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(250, 247, 255, 1.0))),
                              onPressed: () async {
                                Navigator.pushNamed(context, '/Site',
                                    arguments: {});
                              },
                              icon: Icon(Icons.chevron_right,
                                  color: Color.fromRGBO(210, 124, 44, 1.0)),
                              label: Text("")),
                          subtitle: Text(email[index].toString()),
                          title: Text(namee[index])),
                    );
                  }),
            )
          ])),
          isLoading
              ? SpinKitSquareCircle(
                  color: Colors.red,
                  size: 50.0,
                  duration: const Duration(milliseconds: 1200))
              : Stack()
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
}

ClearD() {}
