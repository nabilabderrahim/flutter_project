import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' show json, jsonDecode;
import 'package:version1/api.dart';
import 'package:version1/page/Profile.dart';

import 'Site.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

String idA = "";
int itemmcount = 1;
String etatA = "";
String nname = "";
String timeA = "";
String sever = "";
String nameP = "";
String country = "";
String city = "";
String phone = "";
String emailP = "";

clearall() {
  nameP = "";
  country = "";
  city = "";
  phone = "";
  emailP = "";
  nname = "";
  timeA = "";
  sever = "";
  itemmcount = 0;
  etatA = "";
  idA = "";
}

class _HomeState extends State<Home> {
  String apiUrl = "https://www.metaweather.com/api/location/search/?query=";
  int woeid = 0;
  List list = [];
  void fetchWeather() async {
    var searchResult = await http.get(Uri(path: apiUrl));
    var result = json.decode(searchResult.body[0]);
    print("1" + result.toString());
    setState(() {
      woeid = result['woeid'];
    });
  }

  String degre = '';
  String location = '';
  String? icon;
  String description = '';
  bool isMorning = false;

  Future<void> getDegre() async {
    try {
      String url =
          'http://api.openweathermap.org/data/2.5/weather?q=$villa&units=Metric&appid=ce21d1a4a4f554464591558e3544afe9';
      var response = await http.get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      print(data);
      degre = data['main']['temp'].toString();
      icon = data['weather'][0]['icon'].toString();
      description = data['weather'][0]['main'].toString();
      String long = data['coord']['lon'].toString();
      String lat = data['coord']['lat'].toString();
      String url2 =
          "https://api.openweathermap.org/data/2.5/forecast?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat}&lon=${long}";
      var response2 = await http.get(Uri.parse(url2));
      Map data2 = jsonDecode(response2.body);

      for (dynamic e in data2['list']) {
        if (list.length < 6) {
          Map weatherDaily = {
            "temp": double.parse(e['main']['temp'].toString()) - 273.15,
            "main": e['weather'][0]['main'],
            "icon": e['weather'][0]['icon']
          };
          list.add(weatherDaily);
        } else {
          break;
        }
        int hour = 0;
        String value = DateTime.now().hour.toString();
        //  Variables.selectedDestination.local_time.toString().substring(0, 1);
        if (value == "+") {
          hour = DateTime.now().hour;
          //  +int.parse(Variables.selectedDestination.local_time.toString().substring(1));
        } else {
          hour = DateTime.now().hour;
          //  -int.parse(Variables.selectedDestination.local_time.toString().substring(1));
        }
        if (hour < 19 && hour > 5) {
          isMorning = true;
        }
      }
      print(list.length);
      //print(list);
    } catch (e) {
      print('erreur : $e');
      degre = 'we cant get the data';
    }
    setState(() {});
  }

  deb() async {
    await gettoken();
    await alarm();
    alarmDevice();
    await profile();
    getDegre();
    super.initState();
  }

  @override
  void initState() {
    deb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        leading: new Container(),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: list.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Stack(
              children: [
                Image.asset(
                    isMorning ? "assets/morning.png" : "assets/night.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity),
                Container(decoration: BoxDecoration(color: Colors.black38)),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 80),
                                icon != null
                                    ? Image.network(
                                        'https://openweathermap.org/img/w/${icon}.png',
                                        fit: BoxFit.cover,
                                        height: 70,
                                        width: 70,
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/Site');
                                        },
                                        icon: Icon(Icons.villa),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.transparent)),
                                        label: Text('')),
                                    Text(
                                      "$villa",
                                      //Variables.selectedDestination.destination,
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  description,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat('yMMMMEEEEd')
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$degre" + "\u00B0",
                                  style: TextStyle(
                                      fontSize: 65,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                        isMorning
                                            ? Icons.wb_sunny_outlined
                                            : Icons.nightlight_outlined,
                                        color: Colors.white,
                                        size: 34),
                                    SizedBox(width: 10),
                                    Text(
                                      ""
                                      /* isMorning
                                          ? AppLocalizations.of(context)!
                                              .morning
                                          : AppLocalizations.of(context)!.night*/
                                      ,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white30)),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(children: [
                                for (int i = 1; i < 6 + 1; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                            DateFormat('EE').format(
                                                DateTime.now()
                                                    .add(Duration(days: i))),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Image.network(
                                          'https://openweathermap.org/img/w/${list[i - 1]['icon']}.png',
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        ),
                                        Text(
                                            "${list[i - 1]['temp'].toString().substring(0, 2)} \u00B0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )
                              ]),
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      )
                    ],
                  ),
                )
              ],
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
                  Navigator.pushNamed(context, '/Camera',
                      arguments: {etatA, idA, itemmcount, nname, timeA, sever});
                },
                color: Colors.blue,
                icon: Icon(Icons.camera_alt, color: Colors.white),
              ),
              label: ('Stream'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Profile',
                      arguments: {nameP, country, city, phone, emailP});
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

  Future alarm() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/alarm/DEVICE/4e98f3f0-b0c7-11ec-8ea2-c70cb76c1d8e?pageSize=10&page=0'));

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
      var x = body["data"][0]["id"]["id"].toString();

      var z = body["data"][0]["status"].toString();
      itemmcount = y;
      print("hello" + x);

      print("ee" + z);
      etatA = z;
      idA = x;
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future alarmDevice() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET', Uri.parse('http://91.134.146.229:19999/api/alarm/info/$idA'));

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

      var x = body["originatorName"].toString();
      var timed = body["createdTime"].toString();
      var s = body["severity"].toString();
      nname = x;
      timeA = timed;
      sever = s;
      print(timeA);
      print("alarmid" + x);
      print("etat:" + s);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future profile() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request('GET',
        Uri.parse('http://91.134.146.229:19999/api/customer/' + idCustomer));

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
      var y = (body.toString());

      print("Nbre Elements : " + y.toString());
      var named = body["title"].toString();
      print("name" + named);
      var countryd = body["country"].toString();
      print("country" + countryd);
      var cityd = body["city"].toString();
      print("city:" + cityd);
      var phoned = body["phone"].toString();
      print("numbr" + phoned);
      var emaild = body["email"].toString();
      print("@" + emaild);
      nameP = named;
      country = countryd;
      city = cityd;
      phone = phoned;
      emailP = emaild;
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }
}
