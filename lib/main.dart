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
  var videos;

  _fetchData() async {
    print("Attempting to fetch data by http request...");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   print(response.body);
    // }
    // print("\n");

    final map = json.decode(response.body);
    final videosJson = map["videos"];

    // videosJson.forEach((video) {
    //   print(video["name"]);
    // });

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
                    return new HomeTableCell(video);
                  },
                ),
        ),
      ),
    );
  }
}

class HomeTableCell extends StatelessWidget {
  final video;
  HomeTableCell(this.video);

  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.network(video["imageUrl"]),
              new Container(
                height: 8.0,
              ),
              new Text(
                video["name"],
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        new Divider()
      ],
    );
  }
}

/*
1.What is setState() ?
Answer: https://stackoverflow.com/questions/51283077/when-use-setstate-in-flutter

*/
