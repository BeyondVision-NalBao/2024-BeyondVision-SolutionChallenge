import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_categories.dart';
import 'package:flutter/material.dart';

class BigBox extends StatelessWidget {
  final int cateNum;
  final String name;
  final bool? isRoutine;
  const BigBox(
      {super.key, required this.cateNum, required this.name, this.isRoutine});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(boxColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            if (cateNum == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories(
                            cate: 0,
                            name: "상체",
                            isRoutine: isRoutine,
                          )));
            } else if (cateNum == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories(
                            cate: 1,
                            name: "하체",
                            isRoutine: isRoutine,
                          )));
            } else if (cateNum == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories(
                            cate: 2,
                            name: "코어",
                            isRoutine: isRoutine,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories(
                            cate: 3,
                            name: "스트레칭",
                            isRoutine: isRoutine,
                          )));
            }
          },
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
