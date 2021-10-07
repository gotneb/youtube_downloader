import 'package:flutter/material.dart';
import 'package:youtube_downloader/components/banner_video.dart';
import 'package:youtube_downloader/styles/home.dart' as style;

class Home extends StatefulWidget {
  static const String route = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  static const _side = 60.0;
  bool firstTime = true;

  var widgets = <Widget>[];

  _HomeState() {
    var search = makeFieldText();
    widgets.addAll([
      const Text('Youtube', style: style.Home.title),
      const Text('Downloader', style: style.Home.title),
      const SizedBox(height: 15),
      search,
      const SizedBox(height: 45),
    ]);
  }

  Row makeFieldText() {
    final field = TextField(
      enableInteractiveSelection: true,
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.link, color: Colors.grey),
        hintText: 'Cole o link aqui...',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        focusColor: Colors.black,
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
        onPressed: loadBanner,
        icon: const Icon(Icons.search, size: 35, color: style.Home.searchColor),
      ),
    );

    return Row(
      children: [
        Expanded(child: field),
        const SizedBox(width: 8),
        searchButton,
      ],
    );
  }

  void loadBanner() {
    setState(() {
      if (firstTime) {
        widgets.add(BannerVideo(url: _controller.text));
        firstTime = !firstTime;
      } else {
        widgets.removeLast();
        widgets.add(BannerVideo(url: _controller.text));
      }
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
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
        child: ListView(
          children: [body],
        ),
      ),
    );
  }
}
