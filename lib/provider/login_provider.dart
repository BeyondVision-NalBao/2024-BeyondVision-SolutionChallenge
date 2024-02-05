import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLogined = false;

  bool get isLogined => _isLogined;

  // 로그인 상태를 업데이트하고 UI를 리스너들에게 알림
  void updateLoginStatus(bool status) {
    _isLogined = status;
    notifyListeners();
  }
}
