import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_big_box.dart';

import 'package:flutter/material.dart';

class NewWorkOut extends StatelessWidget {
  const NewWorkOut({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context, titleText: "운동 프로그램"),
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.count(
                crossAxisCount: 2,
                children: const [
                  BigBox(cateNum: 0, name: "상체", isRoutine: true),
                  BigBox(cateNum: 1, name: "하체", isRoutine: true),
                  BigBox(cateNum: 2, name: "코어", isRoutine: true),
                  BigBox(cateNum: 3, name: "스트레칭", isRoutine: true),
                ],
              ),
            ),
          ],
        ));
  }
}
