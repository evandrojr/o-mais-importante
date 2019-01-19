import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
onSelectNotification: onSelectNotification  );
  }


  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('Notification'),
              content: new Text('$payload'),
            ));

  }

  // Future onSelectNotification(String payload) {
  //   debugPrint("payload: $payload");
  //   showDialog(
  //       context: context,
  //       builder: (_) => new AlertDialog(
  //             title: new Text('Notification'),
  //             content: new Text('$payload'),
  //           ));
  // }


  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
     //   debugPrint("payload: $payload");
  //   return showDialog(
  //       context: context,
  //       builder: (_) => new AlertDialog(
  //             title: new Text('Notification'),
  //             content: new Text('$payload'),
  //           ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('O Mais Importante'),
      ),
      body: new Center(child: new RaisedButton(onPressed: showNotification,
       child: new Text(
         'Dica do dia',
         style: Theme.of(context).textTheme.headline
       ),)),
    );
  }

  showNotification() async {

var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'your channel id', 'your channel name', 'your channel description',
    importance: Importance.Max, priority: Priority.High);
var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
var platformChannelSpecifics = new NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
await flutterLocalNotificationsPlugin.show(
    0, 'plain title', 'plain body', platformChannelSpecifics,
    payload: 'item id 2');

    // var android = AndroidNotificationDetails(
    //     'channel Id', 'channel NANE', 'channel Description');
    // var iOS = new IOSNotificationDetails();
    // var platform = NotificationDetails(android, iOS);
    // await flutterLocalNotificationsPlugin.show(
    //     0, 'Attention', 'Two new messages', platform, payload: 'Funcione por favor!');
  }
}
