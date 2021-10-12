import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class BannerVideo {
  static const title = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final channel = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 19,
    letterSpacing: 1,
  );

  static const time = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 17,
    letterSpacing: 1.5,
  );

  static const gradientDownload = LinearGradient(
    colors: [
      Color.fromRGBO(186, 83, 212, 1),
      Color.fromRGBO(89, 34, 148, 1),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static const colorIconDownload = Colors.white;

  static const backgroundIconDownload = Color.fromRGBO(164, 57, 230, 1);
}
