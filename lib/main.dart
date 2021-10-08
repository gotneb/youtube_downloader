import 'package:flutter/material.dart';
import 'package:youtube_downloader/screens/downloads.dart';

import 'screens/home.dart';
import 'screens/tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tabbar(screens: <Widget>[
        Home(),
        Downloads(),
      ]),
    );
  }
}
