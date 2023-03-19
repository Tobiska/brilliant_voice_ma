import 'dart:async';

import 'package:brilliant_voices/domain/entity/game_properties.dart';
import 'package:brilliant_voices/domain/entity/user.dart';
import 'package:brilliant_voices/infrustructure/wait.dart';

import '../domain/entity/game.dart';
import '../domain/entity/wait.dart';
import 'game.dart';

abstract class GameUserException implements Exception {}

class GameUserCreateGameException extends GameUserException {}

class GameProvider {
  GameInf game = GameInf.shrink();

  WaitInf wait = WaitInf();

  Stream<Wait> get updateWaitStream => wait.updateWaitController.stream;

  Stream get updateGameStream =>
      game.currentRoundInf.updateRoundStreamController.stream;

  Stream get updateRoundResultStream =>
      game.currentRoundInf.updateRoundResultStreamController.stream;

  Stream get updateTimeStream =>
      game.currentRoundInf.updateTickStreamController.stream;

  Game createGame(User user, GameProperties properties) {
    game = GameInf(
      durationRoundSeconds: properties.roundTime.inSeconds,
      countPlayers: properties.countPlayers,
      owner: user,
    );
    return game.currentRoundInf.currentRound;
  }

  GameProperties joinTheRoom(String username, String code) {
    wait = WaitInf();
    wait.startWait(code, game.countPlayers);
    wait.endWaitStream.listen((event) {
      startGameSession();
    });
    return GameProperties.fromInts(
        countPlayers: game.countPlayers, roundTime: game.durationRoundSeconds);
  }

  GameProperties startGameSession() {
    game.generateRound();
    return GameProperties.fromInts(
        countPlayers: game.countPlayers, roundTime: game.durationRoundSeconds);
  }

  void leavePlayer(String username) {}

  void startNextRound() {
    game.generateRound();
  }

  void sendAnswer(String answer, User user) {
    game.currentRoundInf.addAnswer(answer, user);
  }
}
