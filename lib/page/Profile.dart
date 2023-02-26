import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:version1/page/login.dart';

import '../api.dart';
import '../view/loading.dart';
import 'Home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

bool loading = false;

class _ProfileState extends State<Profile> {
  deb() async {
    setState(() {});
    super.initState();
  }

  void initState() {
    deb();
  }

  clea() {
    loginCtl.clear();
    pwdCtl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              leading: new Container(),
              title: Text("Profile"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 247, 255, 1.0),
              ),
              child: ListView(
                padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
                children: [
                  ListTile(
                    //  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    leading: CircleAvatar(
                        maxRadius: 25.0,
                        backgroundImage: AssetImage(
                          ("assets/iot-logo.jpg"),
                        )),
                    title: Text("Customer"),
                  ),
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text('$nameP'),
                  ),
                  ListTile(
                    title: Text('Country'),
                    subtitle: Text('$country'),
                  ),
                  ListTile(
                    title: Text('City'),
                    subtitle: Text('$city'),
                  ),
                  ListTile(
                    title: Text('Phone'),
                    subtitle: Text('$phone'),
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text('$emailP'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await clea();

                      //  logout();
                      await tbClient.logout();
                      // clearall();
                      Navigator.pushNamed(
                        context,
                        '/Login',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 255, 255, 1.0)),
                    child: ListTile(
                      //  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      leading: Icon(
                        Icons.logout,
                        color: Color(0xFF527DAA),
                      ),
                      title: Text(
                        "Log out",
                        style: TextStyle(color: Color(0xFF527DAA)),
                      ),
                    ),
                  ),
                ],
              ),
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

  Future logout() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'Post', Uri.parse('http://91.134.146.229:19999/api/auth/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      print("logout");
    } else {
      print("rest" + response.reasonPhrase.toString());
    }
  }
}
/*http://91.134.146.229:19999/api/auth/logout*/
