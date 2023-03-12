import 'package:brilliant_voices/pages/join_game/join_game_page.dart';
import 'package:brilliant_voices/pages/wait_page/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/services/game.dart';
import '../../pages/common/constants.dart';

class JoinGameState {
  final String code;
  bool isValid;

  JoinGameState({required this.code, required this.isValid});

  JoinGameState copyWithCode({required String code, required bool isValid}) {
    return JoinGameState(code: code, isValid: isValid);
  }
}

RegExp _codeReg = RegExp('\\d\\d\\d\\d');

class JoinGameViewModel extends ChangeNotifier {
  JoinGameState _state;
  JoinGameState get state => _state;

  GameService _service;

  BuildContext context;

  JoinGameViewModel({required this.context}): _state = JoinGameState(code: "0000", isValid: false), _service = GetIt.instance<GameService>();

  bool onChangeCodeField(String code) {
    _state = _state.copyWithCode(code: code, isValid: _codeReg.hasMatch(code));
    return _state.isValid;
  }

  void onPressedJoinButton() {
    if (_state.isValid) {
      _service.joinTheGame(_state.code);
      Navigator.of(context).pushNamed(WaitPageName);
    }
    //todo throw exc
  }
}