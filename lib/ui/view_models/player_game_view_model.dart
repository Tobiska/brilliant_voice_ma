
import 'dart:async';

import 'package:brilliant_voices/pages/player_game_page/player_game_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/game.dart';
import '../../domain/services/round.dart';
import '../../pages/show_answers_page/show_answers_page.dart';


class State {
  List<PlayerCard> playerCards;
  String answer;
  bool isAnswerFieldLocked;
  String time;
  bool endGame;

  Widget placeholderFirst;
  Widget placeHolderSecond;

  State(
      {required this.playerCards,
      required this.answer,
      required this.isAnswerFieldLocked,
      required this.time,
      required this.endGame,
      required this.placeholderFirst,
      required this.placeHolderSecond});

  State copyWith(Round game) {
    return State(
        playerCards: game.users.map((e) => PlayerCard(username: e.username))
            .toList(),
        answer: answer,
        time: time,
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeHolderSecond,
        isAnswerFieldLocked: isAnswerFieldLocked,
        endGame: endGame
    );
  }

  State copyWithTime(int tick) {
    return State(
        playerCards: playerCards,
        answer: answer,
        time: _timeToString(tick),
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeHolderSecond, isAnswerFieldLocked: isAnswerFieldLocked, endGame: endGame
    );
  }

  String _timeToString(int tick) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes =
    twoDigits(Duration(seconds: tick).inMinutes.remainder(60));
    String twoDigitSeconds =
    twoDigits(Duration(seconds: tick).inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  State copyWithPlaceholderSecond(placeholder) {
    return State(
        playerCards: playerCards,
        answer: answer,
        time: time,
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeholder,
        isAnswerFieldLocked: isAnswerFieldLocked,
        endGame: endGame
    );
  }

  State copyWithLocked(bool isLocked) {
    return State(
        playerCards: playerCards,
        answer: answer,
        time: time,
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeHolderSecond,
        isAnswerFieldLocked: isLocked,
        endGame: endGame
    );
  }

  State copyWithAnswer(String answer) {
    return State(
        playerCards: playerCards,
        answer: answer,
        time: time,
        placeholderFirst: placeholderFirst,
        placeHolderSecond: placeHolderSecond,
        isAnswerFieldLocked: isAnswerFieldLocked,
        endGame: endGame
    );
  }
  
  State.shrink():
      playerCards = [],
      answer = "",
      isAnswerFieldLocked = true,
      time = "00:00",
      endGame = false,
      placeholderFirst = AnswerField(),
      placeHolderSecond = ReadyButton();
}

class PlayerGameViewModel extends ChangeNotifier {
  RoundService _service;
  State _state;
  State get state => _state;

  List<StreamSubscription> subscriptions= [];

  BuildContext context;
  
  PlayerGameViewModel({required this.context}): _service = RoundService.duringGame(), _state = State.shrink() {
    _service.roundStream.listen((game) {
      if (game.isRoundFinished) {
        _goShowAnswerPage();
      } else {
        _state = _state.copyWith(game);
        notifyListeners();
      }
      notifyListeners();
    });
    _listenTimeStream();
  }

  void _listenTimeStream() {
    subscriptions.add(_service.tickStream.listen((time) {
      _state = _state.copyWithTime(time);
      notifyListeners();
    }));
  }

  void _goShowAnswerPage() {
    _stopListening();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder:
            (BuildContext context) => ShowAnswersPage.create()
        ));
    _service.readyForShowResults();
  }

  void _stopListening() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }

  void onChangedAnswerField(String text) {
    _state = _state.copyWithAnswer(text);
  }
  
  void onPressedReadyButton () {
    _state = _state.copyWithPlaceholderSecond(WaitButton());
    _state = _state.copyWithLocked(false);
    _service.sendAnswer(_state.answer);
    notifyListeners();
  }
}
