import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
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
              onPressed: () {},
              child: const Text("회원탈퇴",
                  style: TextStyle(color: Colors.red, fontSize: 24)))
        ]),
      ),
    );
  }
}
