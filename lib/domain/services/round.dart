import 'dart:async';

import 'package:brilliant_voices/domain/entity/game.dart';
import 'package:brilliant_voices/domain/services/user.dart';
import 'package:brilliant_voices/infrustructure/game_user_provider.dart';
import 'package:get_it/get_it.dart';

import '../entity/user.dart';
import 'game.dart';

const MinPlayers = 2;
const MaxPlayers = 6;

class CountPlayersInvalidError implements Exception {}

class RoundTimeInvalidError implements Exception {}

class RoundService {
  final GameProvider _roundProvider;
  final GameService _gameService;

  late Ticker _ticker;
  Stream<int> get tickStream => _ticker.ticks();

  List<StreamSubscription> subscriptions = [];

  final StreamController<Round> _roundStreamController;
  Stream get roundStream => _roundStreamController.stream;

  RoundService()
      : _roundStreamController = StreamController<Round>(),
        _roundProvider = GetIt.instance<GameProvider>(),
        _gameService = GetIt.instance<GameService>();

  RoundService.duringGame()
      : _roundStreamController = StreamController<Round>(),
        _roundProvider = GetIt.instance<GameProvider>(),
        _gameService = GetIt.instance<GameService>()
    {
      startGameSession();
  }

  void leaveTheGame() async {
    User user =  await _gameService.getUser();
    _roundProvider.leavePlayer(user.username);
  }

  void readyForShowResults() {
    _stopListeners();
    _roundProvider.game.currentRoundInf.pushRoundResult();
  }

  void startGameSession() {
    _ticker = Ticker(currentTick: _gameService.properties.roundTime.inSeconds);
    _roundProvider.startGameSession();
    subscriptions.add(_roundProvider.updateGameStream.listen((event) {
      _roundStreamController.add(event);
    }));
  }

  void _stopListeners() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }

  void sendAnswer(String answer) async {
    _roundProvider.sendAnswer(answer, await _gameService.getUser());
  }
}

class Ticker {
  int currentTick;
  Ticker({required this.currentTick});

  void updateTick(int currentRealTick) {
    currentTick = currentRealTick;
  }

  Stream<int> ticks() {
    return Stream<int>.periodic(
        const Duration(seconds: 1), (x) => currentTick - x - 1);
  }
}
