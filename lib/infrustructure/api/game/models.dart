import '../../../domain/entity/game_properties.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/user.dart';

part 'models.g.dart';

@JsonSerializable()
class ApiCreateRequestGame {
  final String username;
  final String id;
  @JsonKey(name: "count_players")
  final int countPlayers;
  @JsonKey(name: "time_duration")
  final int timeDuration;

  ApiCreateRequestGame(
      this.username, this.id, this.countPlayers, this.timeDuration);

  ApiCreateRequestGame.fromDomain(
      {required GameProperties properties, required User user})
      : username = user.username,
        id = user.code,
        countPlayers = properties.countPlayers,
        timeDuration = properties.roundTime.inSeconds;

  factory ApiCreateRequestGame.fromJson(Map<String, dynamic> json) =>
      _$ApiCreateRequestGameFromJson(json);
  Map<String, dynamic> toJson() => _$ApiCreateRequestGameToJson(this);
}

@JsonSerializable()
class ApiResponseCreateGame {
  @JsonKey(name: "join_code")
  final String joinCode;
  @JsonKey(name: "message")
  final String message;

  ApiResponseCreateGame(this.joinCode, this.message);

  factory ApiResponseCreateGame.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseCreateGameFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseCreateGameToJson(this);
}

@JsonSerializable()
class ApiGame {
  final String code;
  final List<ApiUser> users;
  final ApiProperties properties;
  @JsonKey(name: "owner_name")
  final String ownerName;
  final String status;
  @JsonKey(name: "rest_time")
  final String restTime;
  final ApiRound round;
  @JsonKey(name: "number_of_round")
  final int numberOfRound;

  ApiGame(this.code, this.ownerName, this.status, this.users,
      this.numberOfRound, this.restTime, this.round, this.properties);

  factory ApiGame.fromJson(Map<String, dynamic> json) =>
      _$ApiGameFromJson(json);
  Map<String, dynamic> toJson() => _$ApiGameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ApiUser {
  //todo icon
  final String name;
  @JsonKey(name: "is_ready")
  final bool isReady;

  ApiUser(this.name, this.isReady);

  factory ApiUser.fromJson(Map<String, dynamic> json) =>
      _$ApiUserFromJson(json);
  Map<String, dynamic> toJson() => _$ApiUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ApiProperties {
  @JsonKey(name: "count_players")
  int countPlayers;
  @JsonKey(name: "time_duration")
  int timeDuration;

  ApiProperties(this.countPlayers, this.timeDuration);

  factory ApiProperties.fromJson(Map<String, dynamic> json) =>
      _$ApiPropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$ApiPropertiesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ApiRound {
  final String question;
  final Map<String, ApiAnswer> answers;

  ApiRound(this.question, this.answers);

  factory ApiRound.fromJson(Map<String, dynamic> json) =>
      _$ApiRoundFromJson(json);
  Map<String, dynamic> toJson() => _$ApiRoundToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ApiAnswer {
  @JsonKey(name: "text_answer")
  final String textAnswer;
  @JsonKey(name: "is_correct")
  final bool isCorrect;

  ApiAnswer(this.textAnswer, this.isCorrect);

  factory ApiAnswer.fromJson(Map<String, dynamic> json) =>
      _$ApiAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$ApiAnswerToJson(this);
}
