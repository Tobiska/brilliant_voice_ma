import 'package:brilliant_voices/domain/entity/user.dart';

class RoundResult {
  List<UserAnswer> userAnswers;
  bool isWin;

  RoundResult({required this.userAnswers, required this.isWin});
  RoundResult.shrink(): userAnswers = [], isWin = false;

}

class UserAnswer {
  User user;
  String answer;

  UserAnswer({required this.user, required this.answer});
}