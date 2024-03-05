import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/provider/routine_provider.dart';
import 'package:beyond_vision/ui/routine/widgets/new_workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewName extends StatefulWidget {
  final bool isExist;
  int? index;
  NewName({super.key, required this.isExist, this.index});

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
    RoutineProvider routineProvider = Provider.of<RoutineProvider>(context);
    String textContent = "";
    return Dialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
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
            onChanged: (value) {
              setState(() => textContent = _name.text);
            },
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                if (widget.isExist) {
                  //수정
                  //현재 받아온 list에서 해당 내용을 변경 후 전달
                  routineProvider.editName(widget.index!, _name.text);
                  Navigator.pop(context);
                } else {
                  //생성

                  routineProvider.newName = _name.text;
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
