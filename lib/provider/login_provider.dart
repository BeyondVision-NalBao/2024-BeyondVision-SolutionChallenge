import 'package:beyond_vision/model/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';

class AuthProvider with ChangeNotifier {
  bool _isLogined = false;
  int memberId = 0;
  int goal = 0;
  bool get isLogined => _isLogined;

  User? user;

  void updateLoginStatus(bool status) {
    _isLogined = status;
    notifyListeners();
  }

  void getUser(User newUser) {
    user = newUser;
  }

  void getMemberId(int id) {
    memberId = id;
    notifyListeners();
  }

  void getGoal(int memberGoal) {
    goal = memberGoal;
    notifyListeners();
  }
}
