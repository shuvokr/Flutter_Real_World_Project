import 'package:flutter/material.dart';

void main() {
  runApp(new FlutterRealWorldApp());
}

class FlutterRealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealWorldState();
  }
}

class RealWorldState extends State<FlutterRealWorldApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter Real World App"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () {
                  print("Reloading...");
                })
          ],
        ),
        body: new Center(
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
