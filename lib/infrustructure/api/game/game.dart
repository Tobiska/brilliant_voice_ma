import 'dart:async';
import 'dart:convert';

import 'package:brilliant_voices/domain/entity/game_properties.dart';
import 'package:brilliant_voices/domain/entity/user.dart';
import 'package:brilliant_voices/domain/entity/wait.dart';
import 'package:brilliant_voices/domain/services/contracts.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'models.dart';

class ApiGameRepository implements GameRepository {
  final String host;
  WebSocketChannel? channel;

  final StreamController<Wait> _waitStreamController;

  ApiGameRepository(String url)
      : host = url,
        _waitStreamController = StreamController<Wait>();

  @override
  Future<String> createGame(GameProperties prop, User user) async {
    http.Response response = await http.post(Uri.http(host),
        body: ApiCreateRequestGame.fromDomain(properties: prop, user: user)
            .toJson());

    ApiResponseCreateGame responseCreateGame = ApiResponseCreateGame.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);

    return responseCreateGame.joinCode;
  }

  @override
  void joinToGame(User user, String code) {
    Uri url =
        Uri.http(host, '/code', {'username': user.username, 'code': code});
    channel =
        IOWebSocketChannel.connect(url.toString().replaceFirst('http', 'ws'));
    channel?.stream.listen((event) {
      _handleRoute(event);
    });
  }

  @override
  Future<void> sendReady() {
    // TODO: implement sendReady
    throw UnimplementedError();
  }

  @override
  Stream<Wait> waitStream() {
    return _waitStreamController.stream;
  }

  void _handleRoute(ApiGame game) {
    switch (game.status) {
      case "WAIT":
        _handleWait(game);
    }
  }

  void _handleWait(ApiGame game) {
    if (channel == null) {
      return;
    } else {
      _waitStreamController.sink.add(Wait(
          code: game.code,
          countPlayers: game.users.length,
          requiredCountPlayers: game.properties.countPlayers,
          finishWaitStatus: WaitStatus.wait));
    }
  }
}
