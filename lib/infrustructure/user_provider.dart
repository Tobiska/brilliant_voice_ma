import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entity/user.dart';

class UserProvider {
  Future<User> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('username', user.username);
    prefs.setBool('is_owner', user.isOwner);
    prefs.setString('code', user.code);

    return User(
        username: prefs.getString('username') ?? "",
        isOwner: prefs.getBool("is_owner") ?? false,
        code: prefs.getString('code') ?? "");
  }

  Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User(
        username: prefs.getString('username') ?? "",
        isOwner: prefs.getBool("is_owner") ?? false,
        code: prefs.getString('code') ?? "");
  }
}
