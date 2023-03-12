import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../infrustructure/game_user_provider.dart';
import '../../infrustructure/user_provider.dart';
import '../entity/game_properties.dart';
import '../entity/user.dart';
import '../entity/wait.dart';

enum StatusNextRound {
  gameContinue,
  gameFinished
}

class GameService {
  final GameProvider _gameProvider;
  final UserProvider _userProvider;

  GameProperties _properties = GameProperties.shrink();
  GameProperties get properties => _properties;

  Stream<Wait> get waitStream => _gameProvider.updateWaitStream;

  GameService():
        _gameProvider = GetIt.instance<GameProvider>(),
        _userProvider = GetIt.instance<UserProvider>()
  ;

  Future<void> createGame(int countPlayers, String roundTime) async {
    _properties = GameProperties(countPlayers: countPlayers, roundTime: roundTime);
    _gameProvider.createGame(
        await getUser(),
        GameProperties(countPlayers: countPlayers, roundTime: roundTime));
  }

  Future<User> getUser() async {
    return await _userProvider.loadUser();
  }

  void joinTheGame(String code) async {
    User user = await getUser();
    _properties = _gameProvider.joinTheRoom(user.username, code);
  }

  StatusNextRound goToNextRound() {
   return _gameProvider.game.generateRound();
  }
}