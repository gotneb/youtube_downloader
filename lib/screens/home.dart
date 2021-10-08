import 'package:flutter/material.dart';
import 'package:youtube_downloader/components/banner_video.dart';
import 'package:youtube_downloader/components/search_video.dart';
import 'package:youtube_downloader/styles/home.dart' as style;

class Home extends StatefulWidget {
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
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 48, 92, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
        child: ListView(
          children: [body],
        ),
      ),
    );
  }
}
