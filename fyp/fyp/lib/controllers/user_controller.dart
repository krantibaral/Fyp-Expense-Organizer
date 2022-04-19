import 'package:flutter/material.dart';

import '../models/user.dart';

class UserController with ChangeNotifier {
  User? user;

  get isLoggedIn => user != null;

  void setUser(User? u) {
    user = u;
    notifyListeners();
    if (u == null) {
      print("Logged Out");
    } else {
      print("Logged In");
    }
  }
}
