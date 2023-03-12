class GameProperties {
  final int countPlayers;
  final Duration roundTime; //sec

  GameProperties({required this.countPlayers, required String roundTime}): roundTime = parseDuration(roundTime);
  GameProperties.fromInts({required this.countPlayers, required int roundTime}): roundTime = Duration(seconds: roundTime);
  GameProperties.shrink(): countPlayers = 0, roundTime = Duration.zero;

  String toStringDuration() {
    return '${roundTime.inMinutes}:${roundTime.inSeconds}';
  }
}

Duration parseDuration(String s) {
  int minutes = 0;
  int secs = 0;
  List<String> parts = s.split(':');
  minutes = int.parse(parts[parts.length - 2]);
  secs = int.parse(parts[parts.length - 1]);
  return Duration(minutes: minutes, seconds: secs);
}