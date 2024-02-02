import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/routine/routine.dart';
import 'package:flutter/material.dart';

class RoutineBox extends StatelessWidget {
  const RoutineBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(boxColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Routine()));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "나의 운동 루틴",
                    style: TextStyle(
                        fontSize: 36,
                        color: Color(fontYellowColor),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
