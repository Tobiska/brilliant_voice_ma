enum WaitStatus {
  cancel,
  wait,
  goPlay,
}

class Wait {
  String code;
  int countPlayers;
  int requiredCountPlayers;
  WaitStatus finishWaitStatus = WaitStatus.wait;

  Wait(
      {required this.code,
      required this.countPlayers,
      required this.requiredCountPlayers,
      required this.finishWaitStatus});

  Wait copyWith({required int count, required WaitStatus isFinish}) {
    return Wait(
        code: code,
        countPlayers: count,
        requiredCountPlayers: requiredCountPlayers,
        finishWaitStatus: isFinish);
  }
}
