class User {
  final String username;
  final bool isOwner;

  User({required this.username, required this.isOwner});

  User copyWithUsername({required String username}) {
    return User(
      username: username,
      isOwner: isOwner
    );
  }

  User copyWithOwnerFlag({required String username}) {
    return User(
        username: username,
        isOwner: isOwner
    );
  }
}