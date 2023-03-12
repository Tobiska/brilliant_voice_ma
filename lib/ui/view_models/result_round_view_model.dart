import 'package:brilliant_voices/pages/home_page/home_page.dart';
import 'package:brilliant_voices/pages/player_game_page/player_game_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/services/game.dart';
import '../../domain/services/user.dart';
import '../../pages/game_page/game_page.dart';

class ResultState {
  final String resultText;
  final Image resultImage;

  ResultState.roundWin(): resultText = 'Вы выиграли один балл', resultImage = Image.asset('assets/icons/champ.png');
  ResultState.roundLose(): resultText = 'Вы проиграли', resultImage = Image.asset('assets/icons/champ.png');
}

class ResultViewModel extends ChangeNotifier {
  final ResultState _state;
  ResultState get state => _state;

  BuildContext context;

  final GameService _gameService;
  final UserService _userService;

  ResultViewModel.win({required this.context}): _state = ResultState.roundWin(), _gameService = GetIt.instance<GameService>(), _userService = GetIt.instance<UserService>();
  ResultViewModel.lose({required this.context}): _state = ResultState.roundLose(), _gameService = GetIt.instance<GameService>(), _userService = GetIt.instance<UserService>();

  void onPressedNext() async {
    if  (_gameService.goToNextRound() == StatusNextRound.gameContinue) {
      bool flagOwner = (await _userService.getUser()).isOwner;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder:
              (BuildContext context) => flagOwner ? OwnerGamePage.createDuringGame() : PlayerGamePage.create()
          ));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder:
              (BuildContext context) => HomePage.create()
          ));
    }
  }
}