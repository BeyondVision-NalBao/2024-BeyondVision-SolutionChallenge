import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  late TextEditingController _count;

  @override
  void initState() {
    // TODO: implement initState
    _count = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _count.dispose();
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
            "로그아웃\n하시겠습니까?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          TextButton(
              onPressed: () {},
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
