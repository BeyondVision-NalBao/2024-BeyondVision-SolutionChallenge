import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/routine/widgets/routine_detail.dart';
import 'package:flutter/material.dart';

class RoutineButton extends StatelessWidget {
  final String index;

  final String name;

  const RoutineButton({
    super.key,
    required this.index,
    required this.name,
  });

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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RoutineDetail()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(index,
                  style: const TextStyle(
                      color: Color(fontYellowColor),
                      fontWeight: FontWeight.w900,
                      fontSize: 64)),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
