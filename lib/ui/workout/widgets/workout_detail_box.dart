import 'dart:ui';
import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_explaination.dart';

import 'package:flutter/material.dart';

class WorkOutDetail extends StatelessWidget {
  final String name;
  const WorkOutDetail({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(boxColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 원하는 radius 값 설정
          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => const WorkOutExplain());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: 290,
              height: 50,
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white)
          ]),
        ),
      ),
    );
  }
}
