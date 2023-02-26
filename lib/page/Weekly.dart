import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class Weekly extends StatefulWidget {
  const Weekly({Key? key}) : super(key: key);

  @override
  State<Weekly> createState() => _WeeklyState();
}

List vh = [true, false, true, false];
List nh = ['5', '4', '8', '9'];

class _WeeklyState extends State<Weekly> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('No Data')),
      body: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // Número de elementos del eje horizontal.
              crossAxisCount: 2,
              // Espaciado vertical del eje
              mainAxisSpacing: 25.0,
              // Espaciado horizontal del eje
              crossAxisSpacing: 10.0,
              // La relación de ancho, alto y largo de subcomponentes
              childAspectRatio: 1.0),
          itemBuilder: (BuildContext context, int indexx) {
            {
              print("jjjjj" + indexx.toString());
              print("jjjjj" + nh[indexx].toString());
              print("jjjjj" + vh[indexx].toString());

              return Column(children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 1),
                  height: 100,
                  width: 250,
                  child: Container(
                    child: SwitchListTile(
                      title: Text(
                        nh[indexx],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                      value: vh[indexx],
                      activeColor: Colors.red,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (bool) {},
                      subtitle: Text(
                        vh[indexx].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                )
              ]);
            }
          }),
    );
  }
}
