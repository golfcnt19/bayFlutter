class User {
  final String username;
  final String password;

  User(this.username, this.password);

  @override
  String toString() {
    return "username:$username, password:$password";
  }
}
