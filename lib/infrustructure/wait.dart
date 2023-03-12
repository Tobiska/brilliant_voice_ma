import 'dart:async';

import '../domain/entity/wait.dart';
import 'game_user_provider.dart';

class GameUserJoinGameException extends GameUserException {}

class WaitInf {
  late Wait wait;

  late int requiredCountPlayers;

  final StreamController<bool> endWaitStreamController = StreamController<bool>();
  Stream get endWaitStream => endWaitStreamController.stream;

  final StreamController<Wait> updateWaitController = StreamController<Wait>();
  Stream get updateWaitStream => updateWaitController.stream;

  void startWait(String code, int requiredCount) {
    wait = Wait(code: code, countPlayers: 0, requiredCountPlayers: requiredCount, finishWaitStatus: WaitStatus.wait);
    if (code == '1111') {
      throw GameUserJoinGameException();
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (wait.countPlayers <= 2) {//TODO change local history
        updateWaitController.add(
            wait.copyWith(count: wait.countPlayers++, isFinish: WaitStatus.wait));
      } else {
        updateWaitController.add(
            wait.copyWith(count: wait.countPlayers, isFinish: WaitStatus.goPlay));
        endWaitStreamController.add(true);
        endWaitStreamController.close();
        timer.cancel();
      }
    });
  }
}