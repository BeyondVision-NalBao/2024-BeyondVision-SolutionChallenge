import 'package:beyond_vision/model/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final bool _isLogined = false;
  int memberId = 0;
  int goal = 0;
  bool get isLogined => _isLogined;

  User? user;

  void getUser(User newUser) {
    user = newUser;
  }

  void getMemberId(int id) {
    memberId = id;
  }

  void getGoal(int memberGoal) {
    goal = memberGoal;
  }
}
