import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class NewName extends StatefulWidget {
  const NewName({super.key});

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
          const Text(
            "새로운 루틴",
            style: TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text("새로운 루틴의 이름을\n설정하세요",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 30),
          TextField(
            style: const TextStyle(color: Color(fontYellowColor), fontSize: 40),
            controller: _name,
            // onSubmitted: (String value) async{await showDialog()},
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {},
              child: const Text("생성하기",
                  style:
                      TextStyle(color: Color(fontYellowColor), fontSize: 24)))
        ]),
      ),
    );
  }
}
