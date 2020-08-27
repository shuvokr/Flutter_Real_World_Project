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
  var _isLoading = true; // _ in the first mean, its private

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
                  setState(() {
                    _isLoading = _isLoading ? false : true;
                  });
                })
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new Text("Finished Loading..."),
        ),
      ),
    );
  }
}
