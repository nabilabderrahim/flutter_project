import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonDecode;

import 'package:flutter/material.dart';
import 'Home.dart';

class Site extends StatefulWidget {
  const Site({Key? key}) : super(key: key);

  @override
  State<Site> createState() => _SiteState();
}

String villa = country;
List ville = [
  "Ariana",
  "Béja",
  "Ben Arous",
  "Bizerte",
  "Gabès",
  "Gafsa",
  "Jendouba",
  "Kairouan",
  "Kasserine",
  "Kébili",
  "Kef",
  "Mahdia",
  "Manouba",
  "Médenine",
  "Monastir",
  "Nabeul",
  "Sfax",
  "Sidi Bouzid",
  "Siliana",
  "Sousse",
  "Tataouine",
  "Tozeur",
  "Tunis",
  "Zaghouan"
];

class _SiteState extends State<Site> {
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gérer les villes"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        Image.asset("assets/morning.png",
            fit: BoxFit.cover, height: double.infinity, width: double.infinity),
        ListView.builder(
            itemCount: ville.length,
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(
                onPressed: () {
                  getVille(index);
                  Navigator.pushNamed(context, '/Home', arguments: villa);
                },
                child: Text(ville[index]),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
              );
            })
      ]),
    );
  }

  getVille(int z) {
    villa = ville[z];
  }
}
