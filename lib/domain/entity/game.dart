import 'dart:async';

import 'package:brilliant_voices/domain/entity/question.dart';
import 'package:brilliant_voices/domain/entity/round_result.dart';
import 'package:brilliant_voices/domain/entity/user.dart';

class Game {
  final List<User> users;
  final User owner;
  final Question question;
  Timer timer;
  final bool isRoundFinished;
  final bool readyNextRound;
  final RoundResult roundResult;

  Game(
      {required this.users,
      required this.owner,
      required this.question,
      required this.timer,
      required this.isRoundFinished,
      required this.readyNextRound,
      required this.roundResult});

  Game.shrink()
      : users = [],
        owner = User(username: "", isOwner: false, code: ""),
        question = Question.shrink(),
        isRoundFinished = false,
        roundResult = RoundResult.shrink(),
        readyNextRound = false,
        timer = Timer(Duration.zero, () {});

  Game copyWithFlags({bool isFinished = false, bool readyNext = false}) {
    return Game(
        users: users,
        owner: owner,
        question: question,
        timer: timer,
        roundResult: roundResult,
        readyNextRound: readyNext,
        isRoundFinished: isFinished);
  }

  Game copyWithUsers({required List<User> users}) {
    return Game(
        users: users,
        owner: owner,
        question: question,
        timer: timer,
        roundResult: roundResult,
        readyNextRound: readyNextRound,
        isRoundFinished: isRoundFinished);
  }

  Game copyWithRoundResult({required roundResult}) {
    return Game(
        users: users,
        owner: owner,
        question: question,
        timer: timer,
        roundResult: roundResult,
        readyNextRound: readyNextRound,
        isRoundFinished: isRoundFinished);
  }
}
