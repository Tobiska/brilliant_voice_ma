import 'dart:async';

import 'package:brilliant_voices/domain/services/contracts.dart';
import 'package:get_it/get_it.dart';

import '../entity/user.dart';

class UserService {
  final StreamController<User> userStreamController;
  Stream get userStream => userStreamController.stream;

  UserService()
      : userStreamController = StreamController<User>(),
        userRepository = GetIt.instance<UserRepository>(),
        codeGenerator = GetIt.instance<CodeGenerator>();

  final UserRepository userRepository;
  final CodeGenerator codeGenerator;

  Future<void> createUser(
      {required String username, required bool ownerFlag}) async {
    User user = await userRepository.saveUser(User(
        username: username,
        isOwner: ownerFlag,
        code: codeGenerator.generateCode()));
    userStreamController.add(user);
  }

  Future<User> getUser() async {
    return await userRepository.loadUser();
  }
}
