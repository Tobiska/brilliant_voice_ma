import 'dart:async';

import 'package:brilliant_voices/pages/home_page/home_page.dart';
import 'package:brilliant_voices/pages/player_game_page/player_game_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entity/wait.dart';
import '../../domain/services/game.dart';

class WaitState {
  final String countPlayers;
  final String requiredCountPlayers;
  final String code;

  WaitState(
      {required this.countPlayers,
      required this.requiredCountPlayers,
      required this.code});

  WaitState copyWith(Wait wait) {
    return WaitState(
        countPlayers: wait.countPlayers.toString(),
        requiredCountPlayers: wait.requiredCountPlayers.toString(),
        code: wait.code);
  }
}

class WaitViewModel extends ChangeNotifier {
  WaitState _state;
  WaitState get state => _state;

  final GameService _service;

  List<StreamSubscription> subscriptions = [];

  BuildContext context;

  WaitViewModel({required this.context})
      : _service = GetIt.instance<GameService>(),
        _state = WaitState(
            countPlayers: "0", requiredCountPlayers: "0", code: "0000") {
    subscriptions.add(_service.waitStream.listen((wait) {
      switch (wait.finishWaitStatus) {
        case WaitStatus.wait:
          {
            _state = _state.copyWith(wait);
            break;
          }
        case WaitStatus.goPlay:
          {
            _stopListeners();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => PlayerGamePage.create()),
                    (route) => false);
            break;
          }
        case WaitStatus.cancel:
          _stopListeners();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomePage.create()),
                  (route) => false);
          break;
      }
      notifyListeners();
    }));
  }

  void _stopListeners() {
    for (var element in subscriptions) {
      element.cancel();
    }
  }
}
