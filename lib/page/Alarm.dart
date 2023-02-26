import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../model/alarmmodel.dart';
import 'Home.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

final entityDateFormat = DateFormat('yyyy-MM-dd');

/*String fnc(name){
  if(name=="CLEARED_ACK"){return name=="Cleared Acknowledged";}
};*/
class _AlarmState extends State<Alarm> {
  List<int> _selected = List.generate(itemmcount, (i) => 2);
  deb() async {
    await gettoken();

    setState(() {});
    super.initState();
  }

  @override
  void initState() {
    deb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          itemCount: itemmcount,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Color.fromRGBO(250, 247, 255, 1.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                        textColor: Colors.black54,
                        leading: Icon(Icons.alarm,
                            color: Color.fromRGBO(210, 124, 44, 1.0)),
                        subtitle: Text(
                          "$etatA",
                          style: TextStyle(color: Colors.black12),
                        ),
                        /*Icon(Icons.chevron_right,
                      color: Color.fromRGBO(210, 124, 44, 1.0)),*/

                        title: Text("$nname")),
                  ),
                  Expanded(
                    child: ListTile(
                        textColor: Colors.black54,
                        trailing: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(250, 247, 255, 1.0))),
                            onPressed: () async {
                              setState(() {});
                            },
                            icon: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(210, 124, 44, 1.0)),
                            label: Text("")),
                        subtitle: Text(
                          "$sever",
                          style: TextStyle(color: Colors.red),
                        ),
                        title: Text("$timeA")),
                  ),
                ],
              ),
              /*child: ListTile(
                  textColor: Colors.black54,
                  leading: Icon(Icons.alarm,
                      color: Color.fromRGBO(210, 124, 44, 1.0)),
                  trailing: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(250, 247, 255, 1.0))),
                      onPressed: () {
                        alarm();
                        setState(() {});
                      },
                      icon: Icon(Icons.chevron_right,
                          color: Color.fromRGBO(210, 124, 44, 1.0)),
                      label: Text("")),
                  subtitle: Text(
                    "$etat",
                    style: TextStyle(color: Colors.red),
                  ),
                  /*Icon(Icons.chevron_right,
                      color: Color.fromRGBO(210, 124, 44, 1.0)),*/
                  title: Text("Alarm")),*/
            );
          }),
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
}
