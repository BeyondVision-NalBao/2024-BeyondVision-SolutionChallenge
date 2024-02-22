import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/model/workout_model.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_camera_view.dart';
import 'package:flutter/material.dart';

class WorkOutExplain extends StatelessWidget {
  final WorkOut workout;
  const WorkOutExplain({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            workout.name,
            style: const TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Text(workout.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 28)),
            ),
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CameraView()));
                  },
                  child: const Text("확인 후 운동하기",
                      style: TextStyle(
                          color: Color(fontYellowColor), fontSize: 24))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("닫기",
                      style: TextStyle(color: Colors.white, fontSize: 24))),
            ],
          )
        ]),
      ),
    );
  }
}
