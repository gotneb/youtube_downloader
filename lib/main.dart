import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_downloader/app.dart';
import 'package:youtube_downloader/models/selected_videos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider<SelectedVideos>(
    create: (_) => SelectedVideos(),
    builder: (context, child) => const MyApp(),
  ));
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
