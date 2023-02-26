import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:version1/page/Monthly.dart';
import 'package:version1/page/Node.dart';
import 'package:version1/page/repeter.dart';
import '../api.dart';
import 'extereme.dart';

class Auto extends StatefulWidget {
  const Auto({Key? key}) : super(key: key);

  @override
  State<Auto> createState() => _AutoState();
}

List<String> single = [];
TextEditingController titleController = TextEditingController();
List<List> repeter = [[], []];
List<dynamic> nom_device = [];
List<dynamic> val_max = [];
List<dynamic> val_act = [];
List<dynamic> val_min = [];
int dern = 1;
int id_tache = 0;

List<List> personnel = [
  [0],
  [0],
  [0],
  [0],
  [0],
  [0]
];

List note = [[], [], [], []];

List<dynamic> nom_deviceF = [];
List<dynamic> val_maxF = [];
List<dynamic> val_actF = [];
List<dynamic> val_minF = [];
TimeOfDay? timeDeparture = TimeOfDay(hour: 00, minute: 00);
TimeOfDay? timeOff = TimeOfDay(hour: 00, minute: 00);
TextEditingController dateinput2 = TextEditingController();
TextEditingController OuttimeCtl2 = TextEditingController();
TextEditingController departuretimeCtl2 = TextEditingController();
String departure_hour2 = "";
String off_hour2 = "";
String DateIn2 = "";
String DateOff2 = "";
String yearIn = "";
String monthIn = "";
String dayIn = "";
TimeOfDay? timeDeparture2 = TimeOfDay(hour: 00, minute: 00);
TimeOfDay? timeOff2 = TimeOfDay(hour: 00, minute: 00);
String? _selectedLocation = 'SingleTime';
List<String> _locations = ['SingleTime', 'repeter'];
int item_count = 2;
List vale = [];
List cl = [];

class _AutoState extends State<Auto> {
  ext() async {
    await gettoken();
    deve();
    super.initState();
  }

  @override
  void initState() {
    ext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automatique"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new Row(children: [
                new Flexible(
                  child: TextField(
                    controller: dateinput2,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        DateIn2 = DateFormat('yyyy-MM-dd').format(pickedDate);
                        yearIn = DateFormat('yyyy').format(pickedDate);
                        monthIn = DateFormat('MM').format(pickedDate);
                        dayIn = DateFormat('dd').format(pickedDate);

                        print(yearIn);
                        print(monthIn);
                        print(
                            dayIn); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput2.text =
                              DateIn2; //set output date to TextField value.
                        });
                      } else {
                        DateIn2 =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        yearIn = DateFormat('yyyy').format(DateTime.now());
                        monthIn = DateFormat('MM').format(DateTime.now());
                        dayIn = DateFormat('dd').format(DateTime.now());

                        print(DateIn2.runtimeType);
                        print('55' + DateIn2);
                        print(yearIn);
                        print(monthIn);
                        print(dayIn);
                      }
                    },
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date", //label text of field

                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1),
                          borderRadius: BorderRadius.circular(9)),
                    ),
                  ),
                ),
                new Flexible(
                  child: TextField(
                    controller: departuretimeCtl2,
                    onChanged: (value) {
                      setState(() => departure_hour2 = value + ":00Z");
                    },
                    onTap: () async => {
                      FocusScope.of(context).requestFocus(new FocusNode()),
                      timeDeparture2 = (await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      )),
                      if (timeDeparture2 == null)
                        {
                          print('salut'),
                          departure_hour2 = TimeOfDay.now().hour.toString() +
                              ':' +
                              TimeOfDay.now().minute.toString(),
                          print(departure_hour2),
                          print(departure_hour2.runtimeType),
                        }
                      else
                        {
                          print('coucou'),
                          departure_hour2 =
                              "${timeDeparture2?.hour.toString().padLeft(2, '0')}:${timeDeparture2?.minute.toString().padLeft(2, '0')}",
                          print('depart' + departure_hour2)
                        }
                    },
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.access_time,
                          color: Theme.of(context).colorScheme.secondary),
                      labelText: 'Start',
                      hintText: 'HH:mm',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1),
                          borderRadius: BorderRadius.circular(9)),
                    ),
                  ),
                ),
                new Flexible(
                  child: TextFormField(
                    controller: OuttimeCtl2,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your  departure\'s time' : null,
                    onChanged: (value) {
                      setState(() => off_hour2 = value + ":00Z");
                    },
                    onTap: () async => {
                      FocusScope.of(context).requestFocus(new FocusNode()),
                      timeOff2 = (await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      )),
                      if (timeOff2 == null)
                        {
                          off_hour2 = TimeOfDay.now().hour.toString() +
                              ':' +
                              TimeOfDay.now().minute.toString(),
                          print(off_hour2),
                        }
                      else
                        {
                          off_hour2 =
                              "${timeOff2?.hour.toString().padLeft(2, '0')}:${timeOff2?.minute.toString().padLeft(2, '0')}",
                          print('Fin' + off_hour2)
                        }
                    },
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.access_time,
                          color: Theme.of(context).colorScheme.secondary),
                      labelText: 'End',
                      hintText: 'HH:mm',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1),
                          borderRadius: BorderRadius.circular(9)),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      personnel = [[], [], [], [], [], []];
                      personnel[2].add(int.parse(dayIn));
                      print('kkk' + DateIn2);
                      personnel[3].add(int.parse(monthIn));
                      print('kkk' + DateIn2);
                      personnel[5].add(int.parse(yearIn));
                      personnel[0] = ((calculateHoursInterval(
                          int.parse(timeDeparture2!.hour.toString()),
                          int.parse(timeOff2!.hour.toString()))));
                      print(personnel);
                    },
                    child: Text('Enregistrer'))
              ]),
            ],
          ),
          Card(
            color: Colors.blue,
            //color: Color.fromRGBO(120, 127, 246, 1.0),
            child: ListTile(
                textColor: Colors.black54,
                trailing: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(74, 222, 222, 1.0))),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Extreme',
                        arguments: {item_count, vale, cl});
                    clear();
                    setState(() {});
                  },
                  child: Text('choisir'),
                ),
                title: Text('Etat')),
          ),
          new DropdownButton(
            value: _selectedLocation,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLocation = newValue;
              });
            },
            items: _locations.map((String location) {
              return new DropdownMenuItem<String>(
                onTap: () {
                  if (location == 'SingleTime') {
                    print('hello1');

                    ClearD();
                  }

                  if (location == 'repeter') {
                    print('hello4');

                    Navigator.popAndPushNamed(context, "/repeter");

                    Navigator.of(context).pushNamed('/repeter');
                  }
                  ;
                },
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
          TextField(
            decoration: new InputDecoration(
                border: OutlineInputBorder(), labelText: "Title"),
            keyboardType: TextInputType.text,
            controller: titleController,
          ),
          ElevatedButton(
              onPressed: () {
                AddEvent();
                GetInfo();
                Navigator.pushNamed(context, '/Cronicle',
                    arguments: {nom_device, val_act, val_min, val_max});
              },
              child: Text('Envoyer')),
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
                color: Color.fromRGBO(126, 184, 234, 1),
                icon: Icon(Icons.supervised_user_circle, color: Colors.white),
              ),
              label: ('Profile'),
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }

  List condition() {
    for (int y = 0; y < val_act.length; y++) {
      nom_deviceF.add(nom_device[y]);
      val_actF.add(val_act[y]);
      val_maxF.add(val_max[y]);
      val_minF.add(val_min[y]);
    }
    note[0] = nom_deviceF;
    note[1] = val_actF;
    note[2] = val_maxF;
    note[3] = val_minF;
    print(note);
    return note;
  }

  Future AddEvent() async {
    await condition();
    var headers = {
      'X-API-Key': '1ba1014d3850edbea399c202d779482a',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('http://91.134.146.229:30012/api/app/create_event/v1'));
    request.body = json.encode({
      "plugin": "urlplug",
      "title": titleController.text,
      "enabled": 1,
      "notes": condition().toString(),
      "category": "general",
      "target": "iot-thingsboard-12",
      "params": {
        "data": "",
        "headers": "User-Agent: Cronicle/1.0",
        "method": "POST",
        "timeout": "30",
        "url": "http://localhost:5000/posstr"
      },
      "timing": {
        "hours": personnel[0].toList(), //0,1,2,...,23
        "weekdays": personnel[1].toList(), //0,1,....,6
        "days": personnel[2].toList(), //1,2,3,....,31
        "months": personnel[3].toList(), //1,2,3,...,12
        "minutes": personnel[4], //0,1,2,...,59
        "years": PersoYear.toList(),
      }
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deve() async {
    List kol = [];
    List cle = [];
    final val = Map<String, dynamic>();
    List valeu = [];
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      kol.add(body.toString());
      cle.add(body.keys);
      val.addAll(body);
    } else {}

    List ke = val.keys.toList();
    List jj = val.values.toList();
    int real = jj.length;
    if (real == 0) {
      valeu.add(jj[0][0]["value"]);
    } else {
      for (int k = 0; k < real; k++) {
        valeu.add(jj[k][0]["value"]);
      }
    }

    item_count = real;
    vale = valeu;
    cl = ke;
  }

  calculateHoursInterval(int utc4, int utc5) {
    List<int> hourss = [];

    for (int i = utc4; i <= utc5; i++) {
      hourss.add(i);
    }

    return (hourss);
  }

  Future GetInfo() async {
    var request = http.Request('GET', Uri.parse('http://localhost:3000/info'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      List<dynamic> body = json.decode(res);
      print(body);
      dern = body.length;
      id_tache = body[dern - 1]['id_tache'];
      print(id_tache);
      for (int i = 0; i < dern; i++) {
        if (body[i]['id_tache'] == id_tache) {
          nom_device.add(body[i]['nomdevice']);
          val_act.add(body[i]['value']);
          val_max.add(body[i]['max']);
          val_min.add(body[i]['min']);
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
