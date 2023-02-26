import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;
import '../api.dart';
import '../view/loading.dart';
import 'Sensor.dart';

class data extends StatefulWidget {
  const data({Key? key}) : super(key: key);

  @override
  State<data> createState() => _dataState();
}

bool loading = false;

class _dataState extends State<data> {
  deb() async {
    await gettoken();
    await dataa();
    setState(() {});
    super.initState();
  }

  void initState() {
    deb();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("$name"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: ListView.builder(
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(250, 247, 255, 1.0))),
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.chevron_right,
                                color: Color.fromRGBO(210, 124, 44, 1.0)),
                            label: Text("")),
                        subtitle: Text(DateTime.now().toString()),
                        title: Text("dev[index]")),
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
                      icon: Icon(Icons.supervised_user_circle,
                          color: Colors.white),
                    ),
                    label: ('Profile'),
                    backgroundColor: Colors.blue),
              ],
            ),
          );
  }

  Future dataa() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/b78dd8d0-aeab-11ec-8ea2-c70cb76c1d8e/values/timeseries?keys=temperature%20Indoor&useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());

      List y = body.keys.toList();
      int n = y.length;

      var te = y[0];

      item_count = n;
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }
}
