import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Colors.blue[100],
          child: Center(
            child: SpinKitChasingDots(
              color: Colors.lightBlueAccent,
              size: 50.0,
              duration: const Duration(milliseconds: 1500),
            ),
          ),
        ));
  }
}
