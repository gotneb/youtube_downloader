import 'package:flutter/material.dart';
import 'package:youtube_downloader/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rost',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink[400],
      ),
      home: const App(),
    );
  }
}
