import 'dart:async';

import 'package:brilliant_voices/domain/services/game.dart';

import '../domain/entity/game.dart';
import '../domain/entity/question.dart';
import '../domain/entity/round_result.dart';
import '../domain/entity/user.dart';

List<Question> gameQuestions = [
  Question(questionText: "Как зовут собаку?", answerText: "Хуй его знает"),
  Question(questionText: "Как зовут маму?", answerText: "Хуй его знает"),
  Question(questionText: "Кто такой спермоёж?", answerText: "Хуй его знает"),
  Question(
      questionText: "Заглотус это латинский глагол такой?",
      answerText: "Хуй его знает"),
  Question(questionText: "Мужчины спермобак?", answerText: "Хуй его знает"),
];

const roundCount = 4;


class GameInf {
  final int countPlayers;
  final int durationRoundSeconds;

  User owner = User(username: "", isOwner: false);

  int countRound = 0;

  bool isGameFinished = false;

  RoundInf currentRoundInf;

  GameInf(
      {required this.durationRoundSeconds,
      required this.countPlayers,
      required this.owner})
      : currentRoundInf = RoundInf.shrink();

  GameInf.shrink()
      : currentRoundInf = RoundInf.shrink(),
        countPlayers = 5,
        durationRoundSeconds = 5
  ;

  void finishGame() {
    isGameFinished = true;
    currentRoundInf.roundFinish();
    //TODO add to stream
  }

  StatusNextRound generateRound() {
    if (countRound >= roundCount) {
      return StatusNextRound.gameFinished;
    }
    currentRoundInf = RoundInf(
        owner: owner,
        users: _createUsers(countPlayers, owner),
        question: gameQuestions[++countRound],
        countPlayers: countPlayers,
        durationRoundSeconds: durationRoundSeconds);
    return StatusNextRound.gameContinue;
  }

  List<User> _createUsers(int countUsers, User owner) {
    List<User> users = [owner];
    for (int i = 1; i <= countUsers - 2; i++) {
      users.add(User(username: 'user$i', isOwner: false));
    }
    return users;
  }
}

class RoundInf {
  final Question question;
  final int countPlayers;
  final int durationRoundSeconds;

  List<User> users = [];

  late StreamController<Round> updateRoundStreamController;
  late StreamController<int> updateTickStreamController;
  late StreamController<RoundResult> updateRoundResultStreamController;

  late Timer _roundUpdateTimer;
  late Timer _tickUpdateTimer;
  late Timer _roundFinishTimer;

  List<RoundResult> roundResults = [];
  Round currentRound = Round.shrink();

  final User owner;

  RoundInf.shrink()
      : question = Question.shrink(),
        countPlayers = 0,
        durationRoundSeconds = 0,
        users = [],
        owner = User(username: "", isOwner: true);

  RoundInf(
      {required this.question,
      required this.countPlayers,
      required this.durationRoundSeconds,
      required this.users,
      required this.owner}) {
    currentRound = Round(
        users: users,
        owner: owner,
        question: question,
        timer: Timer(Duration(seconds: durationRoundSeconds), () {}),
        isRoundFinished: false,
        readyNextRound: false,
        roundResult: RoundResult.shrink());
    _initStreams();
    _initTimers();
  }

  void _initStreams() {
    updateRoundStreamController = StreamController<Round>();
    updateTickStreamController = StreamController<int>();
    updateRoundResultStreamController = StreamController<RoundResult>();
  }

  void _initTimers() {
    _roundUpdateTimer = _startUpdateTimer(1);
    _tickUpdateTimer = _startTickTimer(1);
    _roundFinishTimer = _startFinishRoundTimer(durationRoundSeconds);
  }

  Timer _startUpdateTimer(int duration) {
    return Timer.periodic(Duration(seconds: duration), (timer) {
      if (users.length != countPlayers) {
        users.add(User(username: "BOT", isOwner: false));
      } else {
        users.removeLast();
      }
      currentRound = currentRound.copyWithUsers(users: users);
      updateRoundStreamController.add(currentRound);
    });
  }

  Timer _startTickTimer(int duration) {
    return Timer.periodic(Duration(seconds: duration), (timer) {
      updateTickStreamController.add(_roundFinishTimer.tick);
    });
  }

  Timer _startFinishRoundTimer(int duration) {
    return Timer(Duration(seconds: duration), () {
      roundFinish();
      updateRoundStreamController.add(currentRound);
    });
  }

  void pushRoundResult() {
    updateRoundResultStreamController.add(currentRound.roundResult);
  }

  void addAnswer(String answer, User user) {
    currentRound = currentRound.copyWithRoundResult(
        roundResult: RoundResult(
            isWin: answer == currentRound.question.answerText,
            userAnswers: [
              UserAnswer(answer: answer, user: user)
            ]));
  }

  void roundFinish() {
    _roundUpdateTimer.cancel();
    _tickUpdateTimer.cancel();
    currentRound = currentRound.copyWithFlags(isFinished: true);
  }
}
