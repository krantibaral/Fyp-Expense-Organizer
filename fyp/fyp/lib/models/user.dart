class User {
  String name;
  String email;
  String id;
  bool subscribed;

  User({
    required this.name,
    required this.email,
    required this.id,
    required this.subscribed  ,
  });

  static User fromPayload(Map<String, dynamic> rawUser) {
    return User(
      id: rawUser['id'],
      name: rawUser['name'],
      email: rawUser['email'],
      subscribed: rawUser['subscribed'].toString() == 1.toString() 
    );
  }
}
