import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'ListCronicle.dart';

class Yearly extends StatefulWidget {
  const Yearly({Key? key}) : super(key: key);

  @override
  State<Yearly> createState() => _YearlyState();
}

String tit = '';
String nam = '';
List<dynamic> min = [];
List<dynamic> da = [];
List<dynamic> wd = [];
List<dynamic> hou = [];
List<dynamic> mon = [];
List<dynamic> yea = [];

class _YearlyState extends State<Yearly> {
  act() async {
    print(id[k]);
    await Gett();
    setState(() {
      Gett();
    });
    super.initState();
  }

  @override
  void initState() {
    act();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namee[k].toString()),
        centerTitle: true,
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration:
              const BoxDecoration(color: Color.fromRGBO(234, 239, 237, 1.0)),
          child: ListView(padding: EdgeInsets.fromLTRB(5, 30, 5, 0), children: [
            ListTile(
              title: Text('Titre'),
              subtitle: Text(tit),
            ),
            ListTile(
              title: Text('id'),
              subtitle: Text(nam),
            ),
            ListTile(
              title: Text('Minutes'),
              subtitle: Text(min.toString()),
            ),
            ListTile(
              title: Text('Hours'),
              subtitle: Text(hou.toString()),
            ),
            ListTile(
              title: Text('Days'),
              subtitle: Text(da.toString()),
            ),
            ListTile(
              title: Text('WeekDays'),
              subtitle: Text(wd.toString()),
            ),
            ListTile(
              title: Text('Months'),
              subtitle: Text(mon.toString()),
            ),
            ListTile(
              title: Text('Years'),
              subtitle: Text(yea.toString()),
            ),
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

  Future Gett() async {
    var headers = {'X-API-Key': '766ad2cdfd8f8158abe31843444c2cc5'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:30012/api/app/get_event/v1?id=' + id[k]));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      print("12" + res);
      Map<String, dynamic> body = json.decode(res);
      print(body);

      tit = (body["event"]["title"].toString());
      nam = (body["event"]["id"].toString());
      min = body["event"]["timing"]["minutes"];
      hou = body["event"]["timing"]["hours"];
      wd = body["event"]["timing"]["weekdays"];
      mon = body["event"]["timing"]["months"];
      yea = body["event"]["timing"]["years"];
      da = body["event"]["timing"]["days"];
      print("tittt");
      print(tit);
      print(nam);
      print(min);
      print(hou);
      print(wd);
      print(mon);
      print(yea);
      print(da);
    } else {
      print(response.reasonPhrase);
    }
  }
  /* Future Gett() async {
    var headers = {
      'X-API-Key': '766ad2cdfd8f8158abe31843444c2cc5',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET', Uri.parse('http://91.134.146.229:30012/api/app/get_event/v1'));
    request.body = json.encode({"id": "el5ksbc3lrb"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      print("12" + res);
      Map<String, dynamic> body = json.decode(res);
      print(body);

      tit = (body["event"]["title"].toString());
      nam = (body["event"]["id"].toString());
      min = body["event"]["timing"]["minutes"];
      hou = body["event"]["timing"]["hours"];
      wd = body["event"]["timing"]["weekdays"];
      mon = body["event"]["timing"]["months"];
      yea = body["event"]["timing"]["years"];
      da = body["event"]["timing"]["days"];
    } else {
      print(response.reasonPhrase);
    }
  }*/
}
