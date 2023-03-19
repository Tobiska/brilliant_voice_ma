class User {
  final String username;
  final bool isOwner;
  final String code;

  User({required this.username, required this.isOwner, required this.code});

  User copyWithUsername({required String username}) {
    return User(username: username, isOwner: isOwner, code: code);
  }

  User copyWithOwnerFlag({required String username}) {
    return User(username: username, isOwner: isOwner, code: code);
  }
}
