import 'dart:async';

import 'package:brilliant_voices/domain/entity/game.dart';
import 'package:brilliant_voices/domain/entity/game_properties.dart';
import 'package:brilliant_voices/domain/services/contracts.dart';
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
  final PropertiesRepository _propertiesRepository;
  final UserRepository _userRepository;

  late Ticker _ticker;
  Stream<int> get tickStream => _ticker.ticks();

  List<StreamSubscription> subscriptions = [];

  final StreamController<Game> _roundStreamController;
  Stream get roundStream => _roundStreamController.stream;

  RoundService()
      : _roundStreamController = StreamController<Game>(),
        _roundProvider = GetIt.instance<GameProvider>(),
        _userRepository = GetIt.instance<UserRepository>(),
        _propertiesRepository = GetIt.instance<PropertiesRepository>();

  RoundService.duringGame()
      : _roundStreamController = StreamController<Game>(),
        _propertiesRepository = GetIt.instance<PropertiesRepository>(),
        _userRepository = GetIt.instance<UserRepository>(),
        _roundProvider = GetIt.instance<GameProvider>() {
    startGameSession();
  }

  void leaveTheGame() async {
    User user = await _userRepository.loadUser();
    _roundProvider.leavePlayer(user.username);
  }

  void readyForShowResults() {
    _stopListeners();
    _roundProvider.game.currentRoundInf.pushRoundResult();
  }

  void startGameSession() async {
    GameProperties properties = await _propertiesRepository.loadProperties();
    _ticker = Ticker(currentTick: properties.roundTime.inSeconds);
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
    _roundProvider.sendAnswer(answer, await _userRepository.loadUser());
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
