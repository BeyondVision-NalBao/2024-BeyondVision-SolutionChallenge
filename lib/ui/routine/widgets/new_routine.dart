import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_big_box.dart';

import 'package:flutter/material.dart';

class NewRoutine extends StatelessWidget {
  const NewRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  BigBox(name: "상체"),
                  BigBox(name: "하체"),
                  BigBox(name: "코어"),
                  BigBox(name: "스트레칭"),
                ],
              ),
            ),
          ],
        ));
  }
}
