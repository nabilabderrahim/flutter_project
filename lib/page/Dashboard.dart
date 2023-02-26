import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:intl/intl.dart';
import 'package:snapshot/snapshot.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:version1/page/test.dart';
import 'package:version1/view/loading.dart';

import '../api.dart';
import 'Node.dart';
import 'dash.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

int item_count = 10;
TextEditingController dateinput = TextEditingController();
TextEditingController dateoutput = TextEditingController();
TextEditingController OuttimeCtl = TextEditingController();
TextEditingController departuretimeCtl = TextEditingController();
String departure_hour = "";
String off_hour = "";
String DateIn = "";
String DateOff = "";

TimeOfDay? timeDeparture = const TimeOfDay(hour: 00, minute: 00);
TimeOfDay? timeOff = const TimeOfDay(hour: 00, minute: 00);
TextEditingController dateinput2 = TextEditingController();
TextEditingController dateoutput2 = TextEditingController();
TextEditingController OuttimeCtl2 = TextEditingController();
TextEditingController departuretimeCtl2 = TextEditingController();
String departure_hour2 = "";
String off_hour2 = "";
String DateIn2 = "";
String DateOff2 = "";
int x = 0;
int InF = 0;
int OutF = 0;
String nom_Capteur = nameD;
List valTeF1 = [];
List tempsF1 = [];
TimeOfDay? timeDeparture2 = const TimeOfDay(hour: 00, minute: 00);
TimeOfDay? timeOff2 = const TimeOfDay(hour: 00, minute: 00);

List<bool> selected = List<bool>.generate(item_count, (int index) => false);

final List<ChartData> chartData = [];

class _DashboardState extends State<Dashboard> {
  deb() async {
    await gettoken();

    await getSensor();
    await getdata();
    await vee(ind);
    await test5();
    test4();

    super.initState();
  }

  clearZ() {
    chartData.clear();
  }

  tee() async {
    await getdata();
    await getSensor();
    test5();
    vee(ind);
    valTe1;
    temps1;
  }

  fr() async {
    await test5();
    clearZ();
    for (int f = 0; f < 9; f++) {
      chartData.add(ChartData(temps1[f].toString(), double.parse(valTe1[f])));
    }
  }

  @override
  void initState() {
    deb();
  }

  tab() async {
    await test5();
    vee(ind);
    dev1;
    fr();
    tee();
  }

  time_now() {
    Out1 = DateTime.now().millisecondsSinceEpoch;
    Out2 = DateTime.now().millisecondsSinceEpoch;
  }

  final bool _running = true;
  Stream<double> _clock() async* {
    await time_now();
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 60));

      setState(() {
        test5();
        vee(ind);
        dev1;
        // tab();
      });

      getdata();
      getSensor();
      Dashboard();
    }
  }

  ChartSeriesController? _chartSeriesController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: valTe1.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : Center(
              child: StreamBuilder(
                  stream: _clock(),
                  builder: (context, v1) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 0),
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                                minimum: 0,
                                maximum: 100,
                                interval: 5,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                    startValue: 0,
                                    endValue: 30,
                                    color: Colors.green,
                                  ),
                                  GaugeRange(
                                    startValue: 30,
                                    endValue: 65,
                                    color: Colors.orange,
                                  ),
                                  GaugeRange(
                                    startValue: 65,
                                    endValue: 100,
                                    color: Colors.red,
                                  ),
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(
                                    value: double.parse(valD),
                                    enableAnimation: true,
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    widget: Text("$nameD : $valD\u00B0",
                                        style: TextStyle(
                                            color: Colors.red[200],
                                            fontWeight: FontWeight.bold)),
                                    positionFactor: 0.5,
                                    angle: 90,
                                  )
                                ])
                          ],
                        ),
                        Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                              Row(children: [
                                Flexible(
                                  child: TextField(
                                    controller: dateinput,
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
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
                                        DateIn = DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                        print(
                                            DateIn); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          dateinput.text =
                                              DateIn; //set output date to TextField value.
                                        });
                                      } else {
                                        DateIn = DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now());
                                        print(DateIn.runtimeType);
                                        print(DateIn);
                                      }
                                    },
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons
                                          .calendar_today), //icon of text field
                                      labelText:
                                          "Enter Date", //label text of field

                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: departuretimeCtl,
                                    onChanged: (value) {
                                      setState(() =>
                                          departure_hour = value + ":00Z");
                                    },
                                    onTap: () async => {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode()),
                                      timeDeparture = (await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      )),
                                      if (timeDeparture == null)
                                        {
                                          print('salut'),
                                          departure_hour =
                                              TimeOfDay.now().hour.toString() +
                                                  ':' +
                                                  TimeOfDay.now()
                                                      .minute
                                                      .toString() +
                                                  ':00.100',
                                          print(departure_hour),
                                          print(departure_hour.runtimeType),
                                        }
                                      else
                                        {
                                          print('coco'),
                                          departure_hour =
                                              "${timeDeparture?.hour.toString().padLeft(2, '0')}:${timeDeparture?.minute.toString().padLeft(2, '0')}:00.100",
                                          print(departure_hour)
                                        }
                                    },
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.access_time,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      labelText: 'Time Of Departure',
                                      hintText: 'HH:mm',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: dateoutput,
                                    //editing controller of this TextField

                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        DateOff = DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                        print(DateOff);
                                        setState(() {
                                          dateoutput.text = DateOff;
                                        });
                                      } else {
                                        DateOff = DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now());
                                        print(DateOff.runtimeType);
                                        print('DateOff' + DateOff);
                                      }
                                    },
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    cursorHeight: 10,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons
                                          .calendar_today), //icon of text field
                                      labelText:
                                          "Enter Date", //label text of field

                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller: OuttimeCtl,
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter your  departure\'s time'
                                        : null,
                                    onChanged: (value) {
                                      setState(() => off_hour = value + ":00Z");
                                    },
                                    onTap: () async => {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode()),
                                      timeOff = (await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      )),
                                      if (timeOff == null)
                                        {
                                          off_hour =
                                              TimeOfDay.now().hour.toString() +
                                                  ':' +
                                                  TimeOfDay.now()
                                                      .minute
                                                      .toString() +
                                                  ':00.100',
                                          print(off_hour),
                                        }
                                      else
                                        {
                                          off_hour =
                                              "${timeOff?.hour.toString().padLeft(2, '0')}:${timeOff?.minute.toString().padLeft(2, '0')}:00.100",
                                          print(off_hour)
                                        }
                                    },
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.access_time,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      labelText: 'Time Of Departure',
                                      hintText: 'HH:mm',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      String inStmp = DateIn.toString() +
                                          ' ' +
                                          departure_hour;
                                      DateTime InStmp = DateTime.parse(inStmp);
                                      Timestamp myTimeStamp =
                                          Timestamp.fromDate(InStmp);
                                      int In = int.parse(
                                              myTimeStamp.seconds.toString()) *
                                          1000;
                                      print(In);
                                      String outStmp =
                                          DateOff.toString() + ' ' + off_hour;
                                      DateTime OutStmp =
                                          DateTime.parse(outStmp);
                                      Timestamp OutTimeStamp =
                                          Timestamp.fromDate(OutStmp);
                                      int Out = int.parse(
                                              OutTimeStamp.seconds.toString()) *
                                          1000;
                                      print(Out);
                                      setState(() {
                                        test4();
                                        // In1 = In;
                                        //Out1 = Out;
                                        filtrer(In, Out);
                                      });
                                    },
                                    child: const Text('Filtrer')),
                              ])
                            ])),
                        DataTable(
                            columns: [
                              DataColumn(label: Text('date')),
                              DataColumn(label: Text(nameD)),
                            ],
                            rows: List<DataRow>.generate(
                              item_count,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                              temps1[index] * 1000)
                                          .toString())),
                                  DataCell(Text(valTe1[index]))
                                ],
                              ),
                            ))
                      ],
                    );
                  })),
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

  temps_filter(int deb, int fin) {
    InF = deb;
    OutF = fin;
  }

  filtrer(int deb, int fin) async {
    await temps_filter(deb, fin);
    await test6(InF, OutF);
    Navigator.pushNamed(context, '/search',
        arguments: {InF, OutF, tempsF1, valTeF1});
  }

  Future deleted() async {
    await fct();
    test5();
  }

  Future fct() async {
    In1 = 550360021;
    Out1 = 650360021;
  }

  Future test4() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/38f63620-947f-11ec-b808-07a7f2feeb88/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=' +
                nameD +
                '&startTs=$In1&endTs=$Out1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      var y = (body.toString());

      List valT = [];

      List temp = [];
      for (int i = 0; i < 10; i++) {
        valT.add(body[nameD][i]["value"]);
        temp.add(body[nameD][i]["ts"]);
      }
      temps = temp;
      valTe = valT;
      int outt = 0;
      outt = Out1;
    } else {
      print("restest4" + response.reasonPhrase.toString());
    }
  }

  Future test5() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=' +
            nameD +
            '&startTs=$In2&endTs=$Out2'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      var y = (body.toString());

      List valT1 = [];
      List temp1 = [];
      for (int i = 0; i < 10; i++) {
        valT1.add(body[nameD][i]["value"]);
        temp1.add(body[nameD][i]["ts"]);
      }
      temps1 = temp1;
      valTe1 = valT1;
      for (int j = 0; j < 10; j++) {
        chartData.add(ChartData(
            DateTime.fromMillisecondsSinceEpoch(temps1[j]).toString(),
            double.parse(valTe1[j])));
      }
    } else {
      print("restest5" + response.reasonPhrase.toString());
    }
  }

  Future test6(int y, int z) async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=' +
            nameD +
            '&startTs=$y&endTs=$z'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      Map<String, dynamic> body = json.decode(res);
      var y = (body.toString());

      List valT1 = [];
      List temp1 = [];
      for (int i = 0; i < 10; i++) {
        valT1.add(body[nameD][i]["value"]);
        temp1.add(body[nameD][i]["ts"]);
      }
      tempsF1 = temp1;
      valTeF1 = valT1;
      for (int j = 0; j < 10; j++) {
        chartData.add(ChartData(
            DateTime.fromMillisecondsSinceEpoch(tempsF1[j]).toString(),
            double.parse(valTeF1[j])));
      }
    } else {
      print("restest5" + response.reasonPhrase.toString());
    }
  }

  Future getdata() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());

      List y = body.keys.toList();
      List caal = [];
      var named = y[0];
      int n = y.length;
      List val = body.values.toList();
      for (int f = 0; f < n; f++) {
        caal.add(val[f][0]["value"]);
      }
      var cals = val[0][0]["value"];
      print(y);
      print(n);
      print(val);
      value = cals;
      valuee = caal;
      v1 = Snapshot.fromJson(valuee);
      print("saaaa" + v1.toString());
      print("zodzod" + caal.toString());
      print("yo" + y.toString());
      print(n);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future getSensor() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?useStrictDataTypes=false'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2780." + body.toString());

      List<String> y = body.keys.toList();

      int n = y.length;
      dev = y;
      var te = y[0];
      title = te;

      item_count2 = n;
      sensor = te;
      List val = body.values.toList();
      dev1 = val;
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  vee(int j) {
    valD = valuee[j];
    nameD = dev[j];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  // ignore: prefer_typing_uninitialized_variables
  var x;
  final double y;
}
