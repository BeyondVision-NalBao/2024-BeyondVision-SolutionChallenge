import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/home/widgets/home_grid_button.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_suggest_box.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_routine_box.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_big_box.dart';

import 'package:flutter/material.dart';

class WorkOut extends StatelessWidget {
  const WorkOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context, titleText: "운동 하기"),
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SuggestBox(),
            const RoutineBox(),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("운동 프로그램",
                  style: TextStyle(
                      color: Color(fontYellowColor),
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(blurYellowColor),
                    ),
                  ),
                ),
              ),
            ),
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
