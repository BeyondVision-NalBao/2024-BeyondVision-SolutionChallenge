import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:beyond_vision/service/user_service.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            "로그아웃\n하시겠습니까?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          TextButton(
              onPressed: () async {
                bool isLoggedOut = await userService.logout();
                if (isLoggedOut) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              },
              child: const Text("확인",
                  style:
                      TextStyle(color: Color(fontYellowColor), fontSize: 24))),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소",
                  style: TextStyle(color: Colors.white, fontSize: 24)))
        ]),
      ),
    );
  }
}
