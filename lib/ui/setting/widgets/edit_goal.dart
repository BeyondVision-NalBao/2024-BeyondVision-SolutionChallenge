import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class EditGoal extends StatefulWidget {
  const EditGoal({super.key});

  @override
  State<EditGoal> createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
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
    return Dialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              "운동 목표 수정",
              style: TextStyle(
                  color: Color(fontYellowColor),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text("운동 횟수 또는 시간을 \n설정하세요",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 30),
            TextField(
              style:
                  const TextStyle(color: Color(fontYellowColor), fontSize: 40),
              keyboardType: TextInputType.number,
              controller: _count,
              // onSubmitted: (String value) async{await showDialog()},
            ),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () {},
                child: const Text("수정하기",
                    style: TextStyle(
                        color: Color(fontYellowColor), fontSize: 24))),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("취소",
                    style: TextStyle(color: Colors.white, fontSize: 24)))
          ]),
        ),
      ),
    );
  }
}
