import 'dart:async';

import 'package:brilliant_voices/domain/entity/question.dart';
import 'package:brilliant_voices/domain/entity/round_result.dart';
import 'package:brilliant_voices/domain/entity/user.dart';

class Round {
  final List<User> users;
  final User owner;
  final Question question;
  Timer timer;
  final bool isRoundFinished;
  final bool readyNextRound;
  final RoundResult roundResult;

  Round(
      {required this.users,
      required this.owner,
      required this.question,
      required this.timer,
      required this.isRoundFinished,
      required this.readyNextRound,
      required this.roundResult});

  Round.shrink()
      : users = [],
        owner = User(username: "", isOwner: false),
        question = Question.shrink(),
        isRoundFinished = false,
        roundResult = RoundResult.shrink(),
        readyNextRound = false,
        timer = Timer(Duration.zero, () {});

  Round copyWithFlags({bool isFinished = false, bool readyNext = false}) {
    return Round(
        users: users,
        owner: owner,
        question: question,
        timer: timer,
        roundResult: roundResult,
        readyNextRound: readyNext,
        isRoundFinished: isFinished);
  }

  Round copyWithUsers({required List<User> users}) {
    return Round(
        users: users,
        owner: owner,
        question: question,
        timer: timer,
        roundResult: roundResult,
        readyNextRound: readyNextRound,
        isRoundFinished: isRoundFinished);
  }

  Round copyWithRoundResult({required roundResult}) {
    return Round(
        users: users,
        owner: owner,
        question: question,
        timer: timer,
        roundResult: roundResult,
        readyNextRound: readyNextRound,
        isRoundFinished: isRoundFinished);
  }
}
