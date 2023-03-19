import 'dart:async';

import 'package:get_it/get_it.dart';

import '../entity/game_properties.dart';
import '../entity/user.dart';
import '../entity/wait.dart';
import 'contracts.dart';

enum StatusNextRound { gameContinue, gameFinished }

class GameService {
  final GameRepository _gameRepository;
  final UserRepository _userRepository;

  GameService()
      : _gameRepository = GetIt.instance<GameRepository>(),
        _userRepository = GetIt.instance<UserRepository>();

  Future<void> createGame(int countPlayers, String roundTime) async {
    _gameRepository.createGame(
        GameProperties(countPlayers: countPlayers, roundTime: roundTime),
        await _userRepository.loadUser());
  }

  Future<User> getUser() async {
    return await _userRepository.loadUser();
  }

  void joinTheGame(String code) async {
    User user = await getUser();
    _gameRepository.joinToGame(user, code);
  }

  Future<void> goToNextRound() {
    return _gameRepository.sendReady();
  }

  Stream<Wait> get waitStream => _gameRepository.waitStream();
}
