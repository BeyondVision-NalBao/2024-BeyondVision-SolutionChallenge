import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/model/workout_model.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_camera_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';

class WorkOutExplain extends StatefulWidget {
  final WorkOut workout;
  final bool pop;
  const WorkOutExplain({super.key, required this.workout, required this.pop});

  @override
  State<WorkOutExplain> createState() => _WorkOutExplainState();
}

class _WorkOutExplainState extends State<WorkOutExplain> {
  final FlutterTts tts = FlutterTts();

  bool isListening = false;
  int isResult = 1;
  String networkUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    tts.setSpeechRate(0.4);
    tts.setPitch(0.9);
    tts.speak(widget.workout.description);
    super.initState();
    networkUrl = widget.workout.exerciseImageUrl;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(boxColor),
      elevation: 5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.workout.name,
                  style: const TextStyle(
                      color: Color(fontYellowColor),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 520,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(networkUrl),
                        Text(widget.workout.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 28)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                widget.pop
                    ? TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("닫기",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)))
                    : Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => CameraView(
                                //             name: widget.workout.name,
                                //             count: 30)));
                              },
                              child: const Text("확인 후 운동하기",
                                  style: TextStyle(
                                      color: Color(fontYellowColor),
                                      fontSize: 24))),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("닫기",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24))),
                        ],
                      )
              ]),
        ),
      ),
    );
  }
}
