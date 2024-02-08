import 'package:shared_preferences/shared_preferences.dart';
import 'package:beyond_vision/service/date_service.dart';

class LoginService {
  DateService dateService = DateService();

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
}
