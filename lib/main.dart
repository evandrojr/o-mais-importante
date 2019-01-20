import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var dicas = [
  // "jantar fora com a esposa",
  // "Ir mergular"
// Amor do casal – Frequência 3x por semana

  "Assistir filme agarradinho",
  "Dançar colado e se beijando",
  "Preparar refeição especial ou levar para jantar fora",
  "Presentear",
  "Massagem tântrica ou normal mesmo",
  "Sexo transcendental",
  "Levar flores nem que sejam roubadas do jardim",
  "Retrospectiva da vida familiar com os pontos altos e os que podem melhorar",

// Amor para a vizinhança – Frequência trimestral

  "Convidar vizinhos para um churrasco",
  "Visitar os vizinhos",
  "Oferecer ajuda aos vizinhos",

// Amor ao próximo – Frequência mensal

  "Oferecer ajuda a algum transeunte",
  "Conversar com um vendedor ambulante",
  "Bater um papo com moradores de rua",
  "Doar sobras para um limpador de para-brisas",

// Amor para os amigos: Frequência 1x na semana

  "Ligar para bater um papo com um(a) amigo(a)",
  "Marcar para sair um(a) amigo(a)",
  "Fazer uma visita um(a) amigo(a)",
  "Marcar para praticar algum esporte juntos com um(a) amigo(a)",
  "Sair com as famílias de um(a) amigo(a)",
  "Ir no pequeno grupo",
  "Convidar novas pessoas para o pequeno grupo",
  "Praticar esportes com os amigos",
  "Procurar fazer novos amigos",

// Amor para a família: 3x por semana

  "Ligar para os pais",
  "Visitar os pais",
  "Presentear algum familiar",
  "Levar pais no médico",
  "Levar a família no zoológico ou no parque",
  "Cantar juntos em família",
  "Dançar juntos",
  "Ir a com a família igreja ou qualquer outra atividade espiritual que você preferir",
  "Ler juntos o casamento blindado",
  "Ler para as crianças",
  "Abraço coletivo em família",
  "Festival de beijo em família",

// Amor próprio – Frequência diária

  "Ir a praia ou similar",
  "Ir na fazenda ou zoológico",
  "Dançar",
  "Ler um livro que dê prazer e se possível tenha alguma utilidade prática",
  "Se presentear",
  "Aprender algo novo",
  "Inventar um novo hobby de um mês ou para a vida toda",
  "Ir a igreja ou qualquer outra atividade espiritual que você preferir",
  "Praticar algum esporte ao ar livre",
  "Dormir cedo",
  "Comer coisas saudáveis",

// Pet

// Levar para passear
// Dar banho
// Cortar as unhas
];

String sorteio() {
  var rng = new Random();
  return dicas[rng.nextInt(dicas.length)];
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    this.flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android, iOS);
    this.flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    setDayly();
  }

  setDayly() async {
    var time = new Time(8, 4, 0);

    String dica = sorteio();

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0, 'Dica do dia:', dica, time, platformChannelSpecifics,
        payload: 'Dica do dia:\n\n$dica');
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('#ficaadica'),
              content: new Text('$payload'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('O Mais Importante'),
      ),
      body: new Center(
          child: new RaisedButton(
        onPressed: showNotification,
        child: new Text('Quero uma dica agora!',
            style: Theme.of(context).textTheme.headline),
      )),
    );
  }

  showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    String dica = sorteio();
    await flutterLocalNotificationsPlugin.show(
        0, 'Dica do dia:', dica, platformChannelSpecifics,
        payload: 'Dica do dia:\n\n$dica');

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('#ficaadica'),
              content: new Text('Dica do dia:\n\n$dica'),
            ));

    // var android = AndroidNotificationDetails(
    //     'channel Id', 'channel NANE', 'channel Description');
    // var iOS = new IOSNotificationDetails();
    // var platform = NotificationDetails(android, iOS);
    // await flutterLocalNotificationsPlugin.show(
    //     0, 'Attention', 'Two new messages', platform, payload: 'Funcione por favor!');
  }
}
