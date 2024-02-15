import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/routine/widgets/new_workout.dart';
import 'package:flutter/material.dart';

class NewName extends StatefulWidget {
  final bool isExist;
  const NewName({super.key, required this.isExist});

  @override
  State<NewName> createState() => _NewNameState();
}

class _NewNameState extends State<NewName> {
  late TextEditingController _name;

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            widget.isExist ? "새로운 이름" : "새로운 루틴",
            style: const TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(widget.isExist ? "새로운 이름을\n설정하세요" : "새로운 루틴의 이름을\n설정하세요",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 30),
          TextField(
            style: const TextStyle(color: Color(fontYellowColor), fontSize: 40),
            controller: _name,
            // onSubmitted: (String value) async{await showDialog()},
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                if (widget.isExist) {
                  //수정
                  //현재 받아온 list에서 해당 내용을 변경 후 전달
                } else {
                  //생성
                  //운동하기 페이지로 넘어가기
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewWorkOut()),
                  );
                }
              },
              child: Text(widget.isExist ? "수정하기" : "생성하기",
                  style: const TextStyle(
                      color: Color(fontYellowColor), fontSize: 24))),
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
