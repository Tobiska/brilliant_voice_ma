import 'package:brilliant_voices/domain/services/user.dart';
import 'package:brilliant_voices/pages/common/constants.dart';
import 'package:brilliant_voices/pages/create_game_page/create_game_page.dart';
import 'package:brilliant_voices/pages/join_game/join_game_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class HomeViewModelState {
  final String username;
  HomeViewModelState({required this.username});

  HomeViewModelState copyWith({required String username}) {
    return HomeViewModelState(username: username);
  }
}

class HomeViewModel extends ChangeNotifier {
  BuildContext context;

  final UserService _service;

  HomeViewModelState _state;
  HomeViewModelState get state => _state;

  HomeViewModel({required this.context}): _service = GetIt.instance<UserService>(), _state = HomeViewModelState(username: "") {
    _service.userStream.listen((user) {
      _state = _state.copyWith(username: user.username);
      notifyListeners();
    });
  }

  void onChangeUsername(String username) {
    _state = _state.copyWith(username: username);
  }

  void onCreateButtonGame() {
    _service.saveUser(username: _state.username, ownerFlag: true);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CreateGamePage.create()));
  }

  void onJoinButtonGame() {
    _service.saveUser(username: _state.username, ownerFlag: false);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => JoinGamePage.create()));
  }
}