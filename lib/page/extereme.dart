import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:version1/page/Node.dart';
import 'dart:convert' show json, jsonDecode;
import '../api.dart';
import 'ActionAuto.dart';
import 'auto.dart';

class Extreme extends StatefulWidget {
  const Extreme({Key? key}) : super(key: key);

  @override
  State<Extreme> createState() => _ExtremeState();
}

List<String> nomAct = [];
int nbre_Act = 1;
List<List> api = [[], [], [], [], []];
String id7 = idNod;
var m = 1;
int z = 0;
List ide = [];

int nb = 1;
List<List> etat = [[], []];
List<String> maxmin = [];
List<String> temp = [];
List<String> filteredList = [];
int c = 0;
List hel = [];
String hell = '';

List<TextEditingController> maxcontroller =
    List.generate(item_count, (i) => TextEditingController());
TextEditingController delaycontroller = TextEditingController();
List<TextEditingController> mincontroller =
    List.generate(item_count, (i) => TextEditingController());

class _ExtremeState extends State<Extreme> {
  der() async {
    await gettoken();
    getActuator();
  }

  @override
  void initState() {
    print("extre" + item_count.toString());
    print(cl);
    print(vale);
    der();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Etat"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: item_count == 0
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Center(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: item_count,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        borderOnForeground: true,
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(cl[index],
                                  style: TextStyle(
                                      color: Color.fromRGBO(120, 127, 246, 1))),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(

                                        child: Text('Max')),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 50,
                                      height: 30,
                                      child: TextField(
                                        decoration: new InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Max"),
                                        keyboardType: TextInputType.number,
                                        controller: maxcontroller[index],

                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Only numbers can be entered
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(

                                        child: Text('Min')),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 50,
                                      height: 30,
                                      child: TextField(
                                        decoration: new InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Min"),
                                        controller: mincontroller[index],
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Only numbers can be entered
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Column(
                    children: [
                      Card(
                        color: Colors.blue,
                        child: ListTile(
                            textColor: Colors.black54,
                            trailing: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(74, 222, 222, 1.0))),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/Actionauto',
                                    arguments: {nbre_Act, nomAct});
                                clear();
                                setState(() {});
                              },
                              child: Text('choisir Actuator'),
                            ),
                            title: Text('actuator')),
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          child: Center(
                            child: Row(
                              children: [
                                Text('Delay'),
                                Container(
                                  width: 50,
                                  height: 30,
                                  child: TextField(
                                    decoration: new InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "20s"),
                                    keyboardType: TextInputType.number,
                                    controller: delaycontroller,

                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ], // Only numbers can be entered
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      for (int i = 0; i < item_count; i++) {
                                        if (delaycontroller.text.isEmpty) {
                                          delaycontroller.text = '20';
                                        }

                                        maxmin.add(maxcontroller[i].text);
                                        maxmin.add(mincontroller[i].text);
                                        temp.add(delaycontroller.text);
                                      }
                                      for (int j = 0; j < item_count; j++) {
                                        if (maxcontroller[j]
                                            .selection
                                            .isValid) {
                                          addEtat(j);
                                          c++;
                                        }
                                      }
                                      print('zozooo' + item_count.toString());
                                      gettache();
                                      for (int s = 0; s < item_count; s++) {
                                        if (maxcontroller[s]
                                            .selection
                                            .isValid) {
                                          api[s].add(maxcontroller[s].text);
                                          api[s].add(mincontroller[s].text);
                                          api[s].add(delaycontroller.text);
                                          api[s].add(cl[s]);
                                          api[s].add(vale[s]);
                                          api[s].add(p);
                                        }
                                      }
                                      etat[0] = maxmin;
                                      etat[1] = temp;
                                      print(api);

                                      Navigator.pushNamed(
                                          context, '/Automatique',
                                          arguments: api);
                                    },
                                    child: Text('Enregistrer'))
                              ],
                            ),
                          )),
                    ],
                  )
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
                icon: Icon(Icons.supervised_user_circle, color: Colors.white),
              ),
              label: ('Profile'),
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  Future getActuator() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/attributes/CLIENT_SCOPE'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      List body = json.decode(res);
      print("2" + body.toString());
      print(body.runtimeType);
      print(body.length);
      List<String> m = [];
      List valu = [];
      for (int i = 0; i < body.length; i++) {
        m.add(body[i]["key"]);
        valu.add(body[i]["value"]);
      }
      print('list' + m.toString());

      print(valu);
      nomAct = m;
      nbre_Act = body.length;
      print("3");

      print("4");
      var y = (body.toString());
      print(y);
    } else {
      print("ress" + response.reasonPhrase.toString());
    }
  }

  Future loca() async {
    var url = 'http://localhost:3000/info';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      hel = jsonResponse;
      nb = jsonResponse.length;
      print(nb);
    } else {
      print('errr');
    }
  }

  Future addEtat(int k) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://localhost:3000/addt'));
    request.body = json.encode({
      "nomdevice": cl[k],
      "max": int.parse(maxcontroller[k].text),
      "min": int.parse(mincontroller[k].text),
      "value": double.parse(vale[k]),
      "timemax": int.parse(delaycontroller.text),
      "id_tache": p,
      "id_tb": id7,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future gettache() async {
    var url = 'http://localhost:3000/tach';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var h = jsonResponse.length;
      hell = jsonResponse.toString();
      print(jsonResponse);
      p = jsonResponse[h - 1]['id'];
      print(p);
    } else {
      print(response.reasonPhrase);
    }
  }
}

clear() {
  maxmin.clear();
  temp.clear();
}
