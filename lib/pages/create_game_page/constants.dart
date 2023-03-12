import 'package:flutter/material.dart';

import '../common/constants.dart';

var kPropertiesTextStyle = const TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 22,
  color: Colors.white
);

var kSubtitleTextStyle = TextStyle(
  fontFamily: 'Rostov',
  fontWeight: FontWeight.w400,
  fontSize: 37,
    foreground: Paint()
      ..shader = const LinearGradient(
          colors: <Color>[
            Color.fromRGBO(225, 106, 192, 1),
            Color.fromRGBO(155, 70, 150, 1)
          ]
      ).createShader(const Rect.fromLTWH(10, 0, 100, 10)),
    shadows: const [
      boxShadow
    ]
);

var kButtonTextStyle = const TextStyle(
  fontFamily: 'Rostov',
  fontWeight: FontWeight.w200,
  fontSize: 45,
  color: Colors.white,
  shadows: [
    BoxShadow(
      color: Color.fromRGBO(124, 25, 144, 1)
    )
  ]
);