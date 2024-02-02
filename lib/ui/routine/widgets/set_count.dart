import 'package:flutter/material.dart';

class SetCount extends StatefulWidget {
  const SetCount({super.key});

  @override
  State<SetCount> createState() => _SetCountState();
}

class _SetCountState extends State<SetCount> {
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text("운동 횟수 또는 시간을 설정하세요"),
          TextField(
            controller: _count,
            // onSubmitted: (String value) async{await showDialog()},
          ),
          TextButton(onPressed: () {}, child: const Text("저장"))
        ]),
      ),
    );
  }
}
