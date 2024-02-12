import 'package:beyond_vision/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beyond_vision/service/date_service.dart';
import 'package:beyond_vision/model/workout_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  DateService dateService = DateService();
  static const String baseUrl = "/api/v1/member";
  late User _currentUser;
  User get currentUser => _currentUser;

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('loginDate') != null &&
        prefs.getBool('isLogined') != null) {
      if (dateService.compareDate(prefs.getString('loginDate')!)) {
        return prefs.getBool('isLogined')!;
      }
    }

    return false;
  }

  //첫 로그인 또는 로그인
  Future<User> getUserData(String? accessToken) async {
    if (accessToken != null) {
      final url = Uri.https(baseUrl, '/google:$accessToken');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _currentUser = User.fromJson(data);
        return _currentUser;
      }
    }
    throw Error();
  }

  Future<bool> postUserInfo() async {
    final url = Uri.https(baseUrl, '/signup');
    var response = await http.post(url, body: _currentUser);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _currentUser = User.fromJson(data);
      return true;
    }
    throw Error();
  }

  Future<bool> quitUser() async {
    final url = Uri.https(baseUrl, '/signout/:${_currentUser.memberId}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> editUserInfo(int newGoal) async {
    final url = Uri.https(baseUrl, '/info/:${_currentUser.memberId}');
    var response = await http.post(url, body: newGoal);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _currentUser = User.fromJson(data);
      return true;
    }
    return false;
  }
}
