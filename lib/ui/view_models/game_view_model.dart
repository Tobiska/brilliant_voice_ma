import 'dart:async';

import 'package:brilliant_voices/domain/services/round.dart';
import 'package:brilliant_voices/pages/game_page/game_page.dart';
import 'package:brilliant_voices/pages/show_answers_page/show_answers_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/game.dart';

class RoundState {
  List<PlayerCard> playerCards;
  String question;
  String time = "00:00";
  bool endGame;
  Widget placeholderFirst;
  Widget placeHolderSecond;

  RoundState(
      {required this.playerCards,
      required this.question,
      required this.time,
      required this.placeholderFirst,
      required this.placeHolderSecond})
      : endGame = false;
  RoundState.createRoundFirst()
      : playerCards = [],
        question = "",
        time = "00:00",
        endGame = false,
        placeholderFirst = SizedBox.shrink(),
        placeHolderSecond = StartButton();
  RoundState.createRoundDuringGame()
      : playerCards = [],
        question = "",
        time = "00:00",
        endGame = false,
        placeholderFirst = QuestionField(),
        placeHolderSecond = TimerField();

  RoundState copyWith(Game game) {
    return RoundState(
        playerCards:
            game.users.map((e) => PlayerCard(username: e.username)).toList(),
        question: game.question.questionText,
        time: time,
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeHolderSecond);
  }

  RoundState copyWithPlaceholderFirst(placeholder) {
    return RoundState(
        playerCards: playerCards,
        question: question,
        time: time,
        placeholderFirst: placeholder,
        placeHolderSecond: placeHolderSecond);
  }

  RoundState copyWithPlaceholderSecond(placeholder) {
    return RoundState(
        playerCards: playerCards,
        question: question,
        time: time,
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeholder);
  }

  RoundState copyWithTime(int tick) {
    return RoundState(
        playerCards: playerCards,
        question: question,
        time: _timeToString(tick),
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeHolderSecond);
  }

  String _timeToString(int tick) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes =
        twoDigits(Duration(seconds: tick).inMinutes.remainder(60));
    String twoDigitSeconds =
        twoDigits(Duration(seconds: tick).inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

class GameViewModel extends ChangeNotifier {
  final RoundService _service;
  RoundState _state;
  RoundState get state => _state;

  List<StreamSubscription> subscriptions = [];

  BuildContext context;

  GameViewModel({required this.context})
      : _state = RoundState.createRoundFirst(),
        _service = RoundService();

  GameViewModel.duringGame({required this.context})
      : _state = RoundState.createRoundDuringGame(),
        _service = RoundService.duringGame() {
    _listenRoundStream();
    _listenTimeStream();
  }

  void _listenRoundStream() {
    subscriptions.add(_service.roundStream.listen((game) {
      if (game.isRoundFinished) {
        _goShowAnswerPage();
      } else {
        _state = _state.copyWith(game);
        notifyListeners();
      }
    }));
  }

  void _listenTimeStream() {
    subscriptions.add(_service.tickStream.listen((time) {
      _state = _state.copyWithTime(time);
      notifyListeners();
    }));
  }

  void onPressedLeaveTheGame() {
    _stopListening();
    _service.leaveTheGame();
  }

  void _stopListening() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }

  void _goShowAnswerPage() {
    _stopListening();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => ShowAnswersPage.create()));
    _service.readyForShowResults();
  }

  void onPressedStartButton() {
    _state = _state.copyWithPlaceholderFirst(QuestionField());
    _state = _state.copyWithPlaceholderSecond(TimerField());
    _service.startGameSession();
    _listenRoundStream();
    _listenTimeStream();
    notifyListeners();
  }
}
