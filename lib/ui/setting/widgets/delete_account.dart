import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/provider/login_provider.dart';
import 'package:beyond_vision/service/user_service.dart';
import 'package:beyond_vision/ui/login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  UserService userService = UserService();

  int memberId = 2;

  getMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // memberId = prefs.getInt('memberId')!;
    print(memberId);
  }

  @override
  void initState() {
    // TODO: implement initState
    getMemberId();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            "탈퇴 확인",
            style: TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text("회원 탈퇴 시,\n개인정보는 모두 폐기되며, 복구할 수 없습니다.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 30),
          TextButton(
              onPressed: () {
                userService.quitUser(memberId);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("회원탈퇴",
                  style: TextStyle(color: Colors.red, fontSize: 24))),
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
