import '../entity/game.dart';
import '../entity/game_properties.dart';
import '../entity/user.dart';
import '../entity/wait.dart';

abstract class Clearer {
  Future<void> clear();
}

abstract class GameRepository {
  void joinToGame(User user, String code);
  Future<String> createGame(GameProperties prop, User user);
  Future<void> sendReady();
  Stream<Wait> waitStream();
}

abstract class CodeGenerator {
  String generateCode();
}

abstract class UserRepository implements Clearer {
  Future<User> saveUser(User user);
  Future<User> loadUser();
}

abstract class PropertiesRepository implements Clearer {
  Future<void> saveProperties(GameProperties properties);
  Future<GameProperties> loadProperties();
}
