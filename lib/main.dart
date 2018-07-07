import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/drive/drivesList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CoPi',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Merriweather',
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CoPi'),
      ),
      body: futureDriveList(),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: const Icon(Icons.queue),
          title: new Text('Copy'),
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.sd_card),
          title: new Text('Drives'),
        )
      ]),
    );
  }
}
