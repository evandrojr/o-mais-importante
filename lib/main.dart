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
    var android = new AndroidInitializationSettings('app_icon');
    var iOS = new IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload: $payload");
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('Notification'),
              content: new Text('$payload'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('O Mais Importante'),
      ),
      body: new Center(child: new RaisedButton(onPressed: showNotification)),
    );
  }

  showNotification() async {
    var android = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var iOS = new IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show( 3, 'Attention', 'Two new messages', platform);
  }
}
