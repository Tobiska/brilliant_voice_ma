import 'dart:async';

import 'package:brilliant_voices/domain/entity/round_result.dart';
import 'package:brilliant_voices/infrustructure/game_user_provider.dart';
import 'package:get_it/get_it.dart';

AnswersService instance = AnswersService();

class AnswersService {
  final GameProvider _provider;

  final StreamController<RoundResult> _roundResultStreamController;
  Stream get roundResultStream => _roundResultStreamController.stream;

  List<StreamSubscription> subscriptions = [];

  static AnswersService create() {
    return instance;
  }

  AnswersService(): _provider = GetIt.instance<GameProvider>(), _roundResultStreamController = StreamController()  {
    subscriptions.add(_provider.updateRoundResultStream.listen((roundResult) {
        _roundResultStreamController.add(roundResult);
    }));
  }

  void finish() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }
}