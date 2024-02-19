import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/record/record.dart';
import 'package:beyond_vision/ui/routine/routine.dart';
import 'package:beyond_vision/ui/setting/setting.dart';
import 'package:beyond_vision/ui/workout/workout.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String name;
  const HomeButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: const Color(boxColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          if (name == "운동 하기") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WorkOut()));
          } else if (name == "운동 루틴") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RoutinePage(isWorkout: false)));
          } else if (name == "운동 기록") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Record()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Setting()));
          }
        },
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 40,
                color: Color(fontYellowColor),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
