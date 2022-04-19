class User {
  String name;
  String email;
  String id;

  User({
    required this.name,
    required this.email,
    required this.id,
  });

  static User fromPayload(Map<String, dynamic> rawUser) {
    return User(
      id: rawUser['id'],
      name: rawUser['name'],
      email: rawUser['email'],
    );
  }
}
