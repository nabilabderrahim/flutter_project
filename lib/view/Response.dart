import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:version1/page/test.dart';
import 'dart:convert' show json;
import '../api.dart';
import '../view/loading.dart';
import 'package:version1/page/Node.dart';
import 'package:version1/page/dash.dart';

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
TimeOfDay? timeDeparture2 = const TimeOfDay(hour: 00, minute: 00);
TimeOfDay? timeOff2 = const TimeOfDay(hour: 00, minute: 00);
bool loading = false;
List<bool> selected = List<bool>.generate(item_count, (int index) => false);

final List<ChartData> chartData = [];

class Response extends StatefulWidget {
  const Response({Key? key}) : super(key: key);

  @override
  State<Response> createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  Timer? timer;
  ajour() {
    timer = Timer.periodic(
        Duration(seconds: 15),
        (Timer t) => setState(() async {
              Out1 = DateTime.now().millisecondsSinceEpoch;
              Out2 = DateTime.now().millisecondsSinceEpoch;
              getdata();
              test4();
              test5();
            }));
  }

  deb() async {
    await gettoken();
    // hist();
    /* print("temps1" + temps.toString());
    print("temps1" + temps1.toString());
    print("tem1" + valTe.toString());
    print("tem1" + valTe1.toString());
    print("kk" + nameD);*/

    super.initState();
  }

  @override
  void initState() {
    deb();
  }

  final bool _running = true;
  Stream<double> _clock() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 10));
      setState(() {
        dev1;
      });
      print('hooooo' + dev1.toString());

      getdata();
      //getSensor();
      Response();
      Out1 = DateTime.now().millisecondsSinceEpoch;
      Out2 = DateTime.now().millisecondsSinceEpoch;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Dashboard"),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: Center(
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
                                          DateIn2 = DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                          print(
                                              DateIn2); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            dateinput2.text =
                                                DateIn2; //set output date to TextField value.
                                          });
                                        } else {
                                          DateIn2 = DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now());
                                          print(DateIn2.runtimeType);
                                          print(DateIn2);
                                        }
                                      },
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                      controller: departuretimeCtl2,
                                      onChanged: (value) {
                                        setState(() =>
                                            departure_hour2 = value + ":00Z");
                                      },
                                      onTap: () async => {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode()),
                                        timeDeparture2 = (await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        )),
                                        if (timeDeparture2 == null)
                                          {
                                            print('salut'),
                                            departure_hour2 = TimeOfDay.now()
                                                    .hour
                                                    .toString() +
                                                ':' +
                                                TimeOfDay.now()
                                                    .minute
                                                    .toString() +
                                                ':00.100',
                                            print(departure_hour2),
                                            print(departure_hour2.runtimeType),
                                          }
                                        else
                                          {
                                            print('coucou'),
                                            departure_hour2 =
                                                "${timeDeparture2?.hour.toString().padLeft(2, '0')}:${timeDeparture2?.minute.toString().padLeft(2, '0')}:00.100",
                                            print(departure_hour2)
                                          }
                                      },
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                      controller: dateoutput2,
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
                                          DateOff2 = DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                          print(DateOff2);
                                          setState(() {
                                            dateoutput2.text = DateOff2;
                                          });
                                        } else {
                                          DateOff2 = DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now());
                                          print(DateOff2.runtimeType);
                                          print('DateOff' + DateOff2);
                                        }
                                      },
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                      controller: OuttimeCtl2,
                                      validator: (value) => value!.isEmpty
                                          ? 'Enter your  departure\'s time'
                                          : null,
                                      onChanged: (value) {
                                        setState(
                                            () => off_hour2 = value + ":00Z");
                                      },
                                      onTap: () async => {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode()),
                                        timeOff2 = (await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        )),
                                        if (timeOff2 == null)
                                          {
                                            off_hour2 = TimeOfDay.now()
                                                    .hour
                                                    .toString() +
                                                ':' +
                                                TimeOfDay.now()
                                                    .minute
                                                    .toString() +
                                                ':00.100',
                                            print(off_hour2),
                                          }
                                        else
                                          {
                                            off_hour2 =
                                                "${timeOff2?.hour.toString().padLeft(2, '0')}:${timeOff2?.minute.toString().padLeft(2, '0')}:00.100",
                                            print(off_hour2)
                                          }
                                      },
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                        String inStmp = DateIn2.toString() +
                                            ' ' +
                                            departure_hour2;
                                        DateTime InStmp =
                                            DateTime.parse(inStmp);
                                        Timestamp myTimeStamp =
                                            Timestamp.fromDate(InStmp);
                                        int Inn = int.parse(myTimeStamp.seconds
                                                .toString()) *
                                            1000;
                                        print('Inn2' + Inn.toString());
                                        String outStmp = DateOff2.toString() +
                                            ' ' +
                                            off_hour2;
                                        DateTime OutStmp =
                                            DateTime.parse(outStmp);
                                        Timestamp OutTimeStamp =
                                            Timestamp.fromDate(OutStmp);
                                        int Outt = int.parse(OutTimeStamp
                                                .seconds
                                                .toString()) *
                                            1000;
                                        print('Outt2' + Outt.toString());
                                        setState(() {
                                          test5();
                                          In2 = Inn;
                                          Out2 = Outt;
                                        });
                                      },
                                      child: const Text('Filtrer')),
                                  /*  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          test2();
                        });
                      },
                      child: Text('Clear')),*/
                                  /* ElevatedButton(
                      onPressed: () {
                        setState(() {
                          deleted();
                        });
                      },
                      child: Text('clear'))*/
                                ]),
                              ],
                            ),
                          ),
                          SfCartesianChart(
                            series: <ChartSeries>[
                              LineSeries<ChartData, String>(
                                  dataSource: chartData,
                                  color: const Color.fromRGBO(192, 108, 132, 1),
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y),
                            ],
                            primaryXAxis: CategoryAxis(),
                            /* primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: 'Internet speed (Mbps)'))*/
                          ),
                          Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                Row(children: [
                                  Flexible(
                                    child: TextField(
                                      controller: dateinput,
                                      /* decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),*/
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
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                            departure_hour = TimeOfDay.now()
                                                    .hour
                                                    .toString() +
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
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                        setState(
                                            () => off_hour = value + ":00Z");
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
                                            off_hour = TimeOfDay.now()
                                                    .hour
                                                    .toString() +
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
                                      style: const TextStyle(
                                          color: Colors.black54),
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
                                        DateTime InStmp =
                                            DateTime.parse(inStmp);
                                        Timestamp myTimeStamp =
                                            Timestamp.fromDate(InStmp);
                                        int In = int.parse(myTimeStamp.seconds
                                                .toString()) *
                                            1000;
                                        print(In);
                                        String outStmp =
                                            DateOff.toString() + ' ' + off_hour;
                                        DateTime OutStmp =
                                            DateTime.parse(outStmp);
                                        Timestamp OutTimeStamp =
                                            Timestamp.fromDate(OutStmp);
                                        int Out = int.parse(OutTimeStamp.seconds
                                                .toString()) *
                                            1000;
                                        print(Out);
                                        setState(() {
                                          test4();
                                          In1 = In;
                                          Out1 = Out;
                                        });
                                      },
                                      child: const Text('Filtrer')),
                                ])
                              ])),
                          DataTable(
                              columns: const [
                                DataColumn(label: Text('date')),
                                DataColumn(label: Text('Temperature')),
                              ],
                              rows: List<DataRow>.generate(
                                item_count,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(
                                        DateTime.fromMicrosecondsSinceEpoch(
                                                temps[index] * 1000)
                                            .toString())),
                                    DataCell(Text(valTe[index]))
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
                      icon: const Icon(Icons.home, color: Colors.white),
                    ),
                    label: ('Home'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/monitoring',
                        );
                      },
                      color: Colors.blue,
                      icon: const Icon(Icons.dashboard, color: Colors.white),
                    ),
                    label: ('Dashboard'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Devices',
                        );
                      },
                      color: Colors.blue,
                      icon: const Icon(Icons.devices, color: Colors.white),
                    ),
                    label: ('Devices'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Alarm',
                        );
                      },
                      color: Colors.blue,
                      icon: const Icon(Icons.alarm, color: Colors.white),
                    ),
                    label: ('Notification'),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    icon: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/Profile',
                        );
                      },
                      color: Colors.blue,
                      icon: const Icon(Icons.supervised_user_circle,
                          color: Colors.white),
                    ),
                    label: ('Profile'),
                    backgroundColor: Colors.blue),
              ],
            ),
          );
  }

  Future deleted() async {
    await fct();
    test5();
  }

  Future fct() async {
    In1 = 550360021;
    Out1 = 650360021;
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
      print("zodzod" + caal.toString());
      print("yo" + y.toString());
      print(n);
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

  Future test4() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse('http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/' +
            idNod +
            '/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=' +
            nameD +
            '&startTs=$In1&endTs=$Out1'));

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

      List valT = [];

      List temp = [];
      for (int i = 0; i < 10; i++) {
        valT.add(body[nameD][i]["value"]);
        temp.add(body[nameD][i]["ts"]);
      }
      print("Number Elements : " + y.toString());
      print(y.length);
      print(valT);
      print(temp);
      temps = temp;
      valTe = valT;
      int outt = 0;
      outt = Out1;
      print('hhhhhhhhhhhhhh' + outt.toString() + 'hhhh' + In1.toString());
      // for (int j = 0; j < 10; j++) {chartData.add(ChartData((temp[j]), double.parse(valT[j])));}
    } else {
      print("res" + response.reasonPhrase.toString());
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
      print("0");

      String res = await response.stream.bytesToString();
      print("1");
      Map<String, dynamic> body = json.decode(res);
      print("2" + body.toString());

      // Map<String, dynamic> values = await json.decode(body);
      print("3");

      print("4");
      var y = (body.toString());

      List valT1 = [];
      // List valH1 = [];
      List temp1 = [];
      for (int i = 0; i < 10; i++) {
        valT1.add(body[nameD][i]["value"]);
        temp1.add(body[nameD][i]["ts"]);
      }
      print("Number Elements : " + y.toString());
      print(y.length);
      print(valT1);
      print(temp1);
      //   print(valH1);
      temps1 = temp1;
      valTe1 = valT1;

      for (int j = 0; j < 10; j++) {
        chartData.add(ChartData(
            DateTime.fromMillisecondsSinceEpoch(temp1[j]).toString(),
            double.parse(valT1[j])));
      }
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }

/*Future test2() async {
    var headers = {'X-Authorization': tokens};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://91.134.146.229:19999/api/plugins/telemetry/DEVICE/38f63620-947f-11ec-b808-07a7f2feeb88/values/timeseries?limit=10&agg=NONE&orderBy=DESC&useStrictDataTypes=false&keys=temperature,humidity&startTs=550360021&endTs=650360021'));

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
      List z = y.split("humidity");
      List valT1 = [];
      List valH1 = [];
      List temp1 = [];
      if (body.length == 0) {
        print("eeeee" + body.toString());
        valT1 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        temp1 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      } else {
        for (int i = 0; i < 10; i++) {
          valT1.add(body["temperature"][i]["value"]);
          temp1.add(body["temperature"][i]["ts"]);
          valH1.add(body["humidity"][i]["value"]);
        }
      }
      print("Nbre Elements : " + y.toString());
      print(y.length);
      print(valT1);
      print(temp1);
      print(valH1);
      temps1 = temp1;
      valTe1 = valT1;
      valHu1 = valH1;
      //  print("nabil" + temp[4].runtimeType.toString());
      for (int j = 0; j < 10; j++) {
        chartData.add(ChartData(
            DateTime.fromMillisecondsSinceEpoch(temp1[j]).toString(),
            double.parse(valT1[j])));
      }
    } else {
      print("res" + response.reasonPhrase.toString());
    }
  }*/
}

class ChartData {
  ChartData(this.x, this.y);
  // ignore: prefer_typing_uninitialized_variables
  var x;
  final double y;
}
