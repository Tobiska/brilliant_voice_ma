import 'dart:async';

import 'package:brilliant_voices/domain/entity/round_result.dart';
import 'package:brilliant_voices/domain/services/answers.dart';
import 'package:brilliant_voices/pages/game_page/game_page.dart';
import 'package:brilliant_voices/pages/result_round_page/result_round_page.dart';
import 'package:flutter/material.dart';

import '../../pages/show_answers_page/show_answers_page.dart';

class State {
  List<CardAnswer> users;
  bool isWin;
  
  State({required this.users, required this.isWin});
  State.shrink(): users = [], isWin = false;
  
  State copyWith(RoundResult roundResult) {
    return State(
        isWin: roundResult.isWin,
        users: roundResult.userAnswers.map(
            (e) => CardAnswer(
              username: e.user.username,
              answer: e.answer != "" ? MessageBubble(answer: e.answer) : SizedBox.shrink(),
            )).toList()
    );
  }
}

class ShowAnswerViewModel extends ChangeNotifier {
    State _state;
    State get state => _state;

    AnswersService _service;

    List<StreamSubscription> subscriptions = [];

    BuildContext context;

    ShowAnswerViewModel({required this.context}): _state = State.shrink(), _service = AnswersService() {
      subscriptions.add(_service.roundResultStream.listen((roundResult) {
      _state = _state.copyWith(roundResult);
        notifyListeners();
      }));
    }

    void _stopListening() {
      _service.finish();
      for (var sub in subscriptions) {
        sub.cancel();
      }
    }

    void onShowTotal() {
      _stopListening();
      if (_state.isWin) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder:
                (BuildContext context) => ResultRoundPage.createWin()
            ));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder:
                (BuildContext context) => ResultRoundPage.createLose()
            ));
      }
    }
}
