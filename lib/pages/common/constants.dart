import 'dart:ui';

import 'package:flutter/material.dart';

const HomePageName = 'home';
const CreatePageName = 'create';
const JoinPageName = 'join';
const WaitPageName = 'wait';
const AnswerResultPageName = 'answers';
const OwnerGamePageName = 'owner_game';
const PlayerGamePageName = 'player_game';

var kMainColor = const Color.fromRGBO(158, 83, 184, 1.0);
var gradColor = const Color.fromRGBO(53, 26, 63, 1.0);
var secondaryColor = const Color.fromRGBO(27, 24, 24, 1.0);

var kCommonPageMargin = const EdgeInsets.only(top: 7, left: 17, right: 17);
var kCommonAppBarMargin = const EdgeInsets.fromLTRB(15, 5, 10, 10);

const boxShadow = BoxShadow(
    color: Colors.black,
    spreadRadius: 0,
    blurRadius: 0,
    offset: Offset(7, 7)
);

var kBackgroundDecoration = BoxDecoration(
    gradient: RadialGradient(
        center: const Alignment(0.1, -1.2),
        colors: [
          gradColor,
          secondaryColor
        ],
        radius: 2.0,
        stops: const [
          0.1,
          0.7
        ]
    )
);

var titleText = const Text(
  "Громкий вопрос",
  textAlign: TextAlign.center,
  overflow: TextOverflow.clip,
  style: TextStyle(
      fontFamily: 'Rostov',
      fontSize: 70,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(212, 103, 192, 1),
      shadows: [
        boxShadow
      ]
  ),
);