import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/home.dart' as style;

class SearchVideo extends StatelessWidget {
  static const _side = 60.0;

  String get text => _controller.text;

  final VoidCallback onSearchClicked;

  final _controller = TextEditingController();

  SearchVideo(this.onSearchClicked);

  @override
  Widget build(BuildContext context) {
    final text = TextField(
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

    final button = Container(
      height: _side,
      width: _side,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: style.Home.searchBackground,
      ),
      child: IconButton(
        onPressed: onSearchClicked,
        icon: const Icon(Icons.search, size: 35, color: style.Home.searchColor),
      ),
    );

    return Row(
      children: [
        Expanded(child: text),
        const SizedBox(width: 8),
        button,
      ],
    );
  }
}
