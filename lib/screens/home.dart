import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_downloader/components/information/welcome.dart';
import 'package:youtube_downloader/components/banner_video.dart';
import 'package:youtube_downloader/components/search_video.dart';
import 'package:youtube_downloader/styles/home.dart' as style;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SearchVideo search;

  var widgets = <Widget>[];

  _HomeState() {
    search = SearchVideo(loadBanner);
    widgets.addAll([
      const Text('Youtube', style: style.Home.title),
      const Text('Downloader', style: style.Home.title),
      const SizedBox(height: 15),
      search,
      const SizedBox(height: 45),
      const Welcome(),
    ]);
  }

  void loadBanner() {
    setState(() {
      if (widgets.length > 5) {
        widgets.removeLast();
      }
      widgets.add(BannerVideo(url: search.text));
    });
  }

  @override
  void initState() {
    _verifyStoragePermission();
    _verifyNotificationsPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 25, 53, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
        child: ListView(
          children: [body],
        ),
      ),
    );
  }

  Future<void> _verifyStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }

  // Verify if app can send notifcations, otherwise asks to user if it can
  void _verifyNotificationsPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Enviar notificações?'),
            content: Row(
              children: const <Widget>[
                Icon(Icons.notification_add, size: 50),
                SizedBox(width: 15),
                Flexible(
                  child: Text(
                    'Concorda que podemos enviar notificações quando um download terminar?',
                    softWrap: true,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('NÃO'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text('SIM'),
                  onPressed: () {
                    Navigator.pop(context);
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications();
                  }),
            ],
          ),
        );
      }
    });
  }
}
