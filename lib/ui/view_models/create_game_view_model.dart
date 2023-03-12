import 'package:brilliant_voices/pages/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/services/game.dart';
class CreateGameState {

  final String countPlayers;
  final String roundTime;

  CreateGameState({required this.countPlayers, required this.roundTime});

  CreateGameState copyWith(CreateGameState state) {
    return CreateGameState(
      countPlayers: state.countPlayers,
      roundTime: state.roundTime,
    );
  }
}

RegExp _roundReg = RegExp('\\d\\d:\\d\\d');

class CreateGameViewModel extends ChangeNotifier {
  final GameService _service;
  CreateGameState _state;

  CreateGameState get state => _state;

  BuildContext context;

  CreateGameViewModel({required this.context}):
        _state = CreateGameState(countPlayers: "5", roundTime: "00:05"),
        _service = GetIt.instance<GameService>(); //TODO передать через контекст

  bool validateCountPlayers(String strCountPlayers) {
    int? countPlayers = int.tryParse(strCountPlayers);
    if ((countPlayers == null)) {
      return false;
    }
    return true;
  }

  bool validateRoundTime(String roundTime) {
    if (!_roundReg.hasMatch(roundTime)) {
      return false;
    }
    return true;
  }

  void onChangeCountPlayer(String countPlayers) {
    _state = _state.copyWith(CreateGameState(countPlayers: countPlayers, roundTime: _state.roundTime));
  }

  void onChangeTime(String roundTime) {
    _state = _state.copyWith(CreateGameState(countPlayers: _state.countPlayers, roundTime: roundTime));
  }

  void onPressedCreateGame() {
    if (validateCountPlayers(_state.countPlayers) && validateRoundTime(_state.roundTime)) {
      _service.createGame(int.parse(_state.countPlayers), _state.roundTime);
      Navigator.of(context).pushNamedAndRemoveUntil(OwnerGamePageName, (route) => false);
    }
  }
}