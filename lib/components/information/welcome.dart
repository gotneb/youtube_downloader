import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  static const _style = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final body = Column(
      children: <Widget>[
        Center(
          child: RotationTransition(
            turns: _animation,
            alignment: Alignment.center,
            child: Image.asset('assets/black-hole.png', width: 0.6 * width),
          ),
        ),
        const SizedBox(height: 30),
        const Text('Nenhum download feito', style: Welcome._style),
        const SizedBox(height: 10),
        const Text('Que tal iniciar um ?', style: Welcome._style),
      ],
    );

    return body;
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}
