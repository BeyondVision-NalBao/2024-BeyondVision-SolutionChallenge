import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_camera_view.dart';
import 'package:flutter/material.dart';

class WorkOutExplain extends StatelessWidget {
  const WorkOutExplain({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "운동이름",
            style: TextStyle(
                color: Color(fontYellowColor),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          const SingleChildScrollView(
            child: Text("운동 설명 블라블라블라",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24)),
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
