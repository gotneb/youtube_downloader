import 'package:flutter/material.dart';
import 'package:youtube_downloader/components/banner_video.dart';
import 'package:youtube_downloader/styles/home.dart' as style;

class Home extends StatelessWidget {
  static const String route = '/home';

  static const _side = 60.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textUrl = TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.link, color: Colors.grey),
        hintText: 'Cole o link aqui...',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );

    final searchButton = Container(
      height: _side,
      width: _side,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: style.Home.searchBackground,
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search, size: 35, color: style.Home.searchColor),
      ),
    );

    final searchSection = Row(
      children: [
        Expanded(child: textUrl),
        const SizedBox(width: 8),
        searchButton,
      ],
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Youtube', style: style.Home.title),
        const Text('Downloader', style: style.Home.title),
        const SizedBox(height: 15),
        searchSection,
        const SizedBox(height: 20),
        BannerVideo(),
        //Center(child: Image.asset('assets/galaxy.png', width: width / 1.3)),
      ],
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 48, 92, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
        child: body,
      ),
    );
  }
}
