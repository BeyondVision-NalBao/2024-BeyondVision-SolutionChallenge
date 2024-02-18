import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/service/workout_service.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_camera_view.dart';
import 'package:flutter/material.dart';

class SuggestBox extends StatelessWidget {
  const SuggestBox({super.key});

  @override
  Widget build(BuildContext context) {
    WorkOutService workoutService = WorkOutService();
    return FutureBuilder(
        future: workoutService.getRandom(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CameraView(workout: snapshot.data!)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "추천 운동",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Color(fontYellowColor),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text(
              "오류가 발생했습니다.",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            );
          }
        });
  }
}
