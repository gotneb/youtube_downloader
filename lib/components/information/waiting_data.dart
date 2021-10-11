import 'package:flutter/material.dart';

class WaitingData extends StatelessWidget {
  const WaitingData({Key? key}) : super(key: key);

  static const _style = TextStyle(
    color: Colors.white,
    fontSize: 19,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final body = Column(
      children: <Widget>[
        SizedBox(
          width: width / 2,
          height: width / 2,
          child: CircularProgressIndicator(
            strokeWidth: width / 30,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Aguarde um momento...',
          style: _style,
        ),
      ],
    );
    return Center(child: body);
  }
}
