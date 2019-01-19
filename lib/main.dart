import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build  (BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: new Text('O Mais Importante'),
      ),
      body: new Center(
        child: new Text(
          'Missão do dia: ', 
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
