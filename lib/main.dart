import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './views/home_table_cell.dart';

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
  var videos;

  _fetchData() async {
    print("Attempting to fetch data by http request...");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    final map = json.decode(response.body);
    final videosJson = map["videos"];

    setState(() {
      this.videos = videosJson;
      _isLoading = false;
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
                    _isLoading = true;
                    _fetchData();
                  });
                })
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.videos != null ? this.videos.length : 0,
                  itemBuilder: (context, index) {
                    final video = this.videos[index];
                    return new FlatButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {
                          print("Pressed on celll number $index");
                        },
                        child: new HomeTableCell(video));
                  },
                ),
        ),
      ),
    );
  }
}

/*
1.What is setState() ?
Answer: https://stackoverflow.com/questions/51283077/when-use-setstate-in-flutter

*/
