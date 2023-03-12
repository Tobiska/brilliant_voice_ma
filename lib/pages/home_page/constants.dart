import 'package:flutter/material.dart';

import '../common/constants.dart';

var kTitleTextStyle = const TextStyle(
    fontFamily: 'Rostov',
    fontSize: 66,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(212, 103, 192, 1),
    shadows: [
      boxShadow
    ]
);

var kRuleBGColor = const Color.fromRGBO(217, 217, 217, 1);

var kRuleTextStyle = const TextStyle(
  fontFamily: 'Rostov',
  letterSpacing: 2,
  fontSize: 25,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

var kTextActionStyle = TextStyle(
    fontFamily: 'Rostov',
    fontSize: 28,
    fontWeight: FontWeight.w400,
    foreground: Paint()
    ..shader = const LinearGradient(
      colors: <Color>[
        Color.fromRGBO(243, 243, 243, 1),
        Color.fromRGBO(219, 169, 237, 1)
      ]
    ).createShader(const Rect.fromLTWH(0, 50, 0, 40)),
    shadows: const [
      boxShadow
    ]
);


