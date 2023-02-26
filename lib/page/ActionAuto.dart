import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:version1/page/login.dart';
import 'dart:convert' show json, jsonDecode, JSON;
import '../api.dart';
import 'extereme.dart';

class ActionAuto extends StatefulWidget {
  const ActionAuto({Key? key}) : super(key: key);

  @override
  State<ActionAuto> createState() => _ActionAutoState();
}

int p = 0;
List<bool?> _value = [];

List nam = [];

class _ActionAutoState extends State<ActionAuto> {
  deb() async {
    await gettoken();
    super.initState();
  }

  tabb() async {
    await addtache();
    await gettache();
  }

  @override
  void initState() {
    deb();
  }

  @override
  Widget build(BuildContext context) {
    for (int j = 0; j < nbre_Act; j++) {
      _value.add(false);
    }
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: nbre_Act,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                child: CheckboxListTile(
                    title: Text(nomAct[index]),
                    value: _value[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _value[index] = value;
                      });
                    }),
              );
            },
          ),
          Center(
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await tabb();
                      for (int z = 0; z < _value.length; z++) {
                        if (_value[z] == true) {
                          nam.add(nomAct[z]);
                          addAct(z);
                        }
                      }
                      ;
                      Navigator.pushNamed(context, '/Extreme',
                          arguments: {nam, p});
                      print(nam);
                    },
                    child: Text('Enregistrer'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future addAct(int k) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://localhost:3000/Act'));
    request.body = json.encode({
      "nom_action": nomAct[k],
      "id_tache": p,
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

  Future addtache() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://localhost:3000/tach'));

    request.body = json.encode({
      "nom": "test" + m.toString(),
      "username": loginCtl.text,
      "pwd": pwdCtl.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      m++;
    } else {
      print(response.reasonPhrase);
    }
  }
}
