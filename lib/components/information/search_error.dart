import 'package:flutter/material.dart';

class SearchError extends StatelessWidget {
  const SearchError({Key? key}) : super(key: key);

  static const _style = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final body = Column(
      children: [
        Image.asset('assets/meteor.png', width: width / 1.7),
        const SizedBox(height: 25),
        const Text(
          'Vídeo não encontrado.\nTem tem certeza que digitou certo?',
          textAlign: TextAlign.center,
          style: _style,
        ),
      ],
    );

    return Center(child: body);
  }
}
