import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/model/user_model.dart';
import 'package:beyond_vision/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beyond_vision/service/date_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final DateService dateService = DateService();

    try {
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final String? accessToken = googleAuth.accessToken;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setBool("isLogined", true);
        prefs.setString("loginDate", dateService.loginDate(DateTime.now()));
        //멤버 아이디를 set 해두어야할듯함다

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          content: Text("구글 로그인에 오류가 발생했습니다."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('lib/config/assets/Logo.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 55),
                  child: Image(
                    image: AssetImage('lib/config/assets/logo3.png'),
                  ),
                ),
              ],
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loginButton(
                  signInWithGoogle,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(VoidCallback onTap) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(boxColor),
      ),
      onPressed: onTap,
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Image(
                image: AssetImage('lib/config/assets/google.png'),
              ),
            ),
            Text(
              " 구글 아이디로 로그인",
              style: TextStyle(
                  color: Color(fontYellowColor),
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
