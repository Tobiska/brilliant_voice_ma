import 'dart:async';

import 'package:brilliant_voices/infrustructure/user_provider.dart';
import 'package:get_it/get_it.dart';

import '../entity/user.dart';

class UserService {
  final StreamController<User> userStreamController;
  Stream get userStream => userStreamController.stream;

  User _user = User(username: "", isOwner: false);
  User get user => _user;

  UserService()
      : userStreamController = StreamController<User>(),
        _provider = GetIt.instance<UserProvider>();

  final UserProvider _provider;

  Future<void> saveUser({String username = "", bool ownerFlag = false}) async {
    _user = User(username: username, isOwner: ownerFlag);
    _user = await _provider.saveUser(_user);
    userStreamController.add(_user);
  }

  Future<User> getUser() async {
    _user = await _provider.loadUser();
    return _user;
  }
}
