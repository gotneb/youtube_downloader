import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  static const _style = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Center(child: Image.asset('assets/black-hole.png', width: 0.6 * width)),
        const SizedBox(height: 30),
        const Text('Nenhum download feito', style: _style),
        const SizedBox(height: 10),
        const Text('Que tal iniciar um ?', style: _style),
      ],
    );
  }
}
