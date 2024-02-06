import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_categories.dart';
import 'package:flutter/material.dart';

class BigBox extends StatelessWidget {
  final String name;
  const BigBox({super.key, required this.name});

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
            if (name == "상체") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Categories(cate: "상체")));
            } else if (name == "하체") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Categories(cate: "하체")));
            } else if (name == "코어") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Categories(cate: "코어")));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Categories(cate: "스트레칭")));
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
