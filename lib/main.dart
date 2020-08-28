import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  _fetchData() async {
    print("Attempting to fetch data by http request...");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
    }
    print("\n");

    final map = json.decode(response.body);
    final videosJson = map["videos"];
    videosJson.forEach((video) {
      print(video["name"]);
    });
  }

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
                    _isLoading = false;
                    _fetchData();
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
