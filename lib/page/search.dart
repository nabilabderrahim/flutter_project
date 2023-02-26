import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'dash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  deb() {
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
        title: const Text('Historique'),
        centerTitle: true,
      ),
      body: Center(
          child: DataTable(
              columns: [
            DataColumn(label: Text('date')),
            DataColumn(label: Text(nameD)),
          ],
              rows: List<DataRow>.generate(
                10,
                (int index) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(DateTime.fromMicrosecondsSinceEpoch(
                            tempsF1[index] * 1000)
                        .toString())),
                    DataCell(Text(valTeF1[index]))
                  ],
                ),
              ))),
    );
  }
}
