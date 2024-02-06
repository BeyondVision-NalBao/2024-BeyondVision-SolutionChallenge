import 'package:beyond_vision/ui/routine/widgets/new_routine_name.dart';
import 'package:beyond_vision/ui/routine/widgets/new_workout.dart';
import 'package:beyond_vision/ui/routine/widgets/routine_detail.dart';
import 'package:flutter/material.dart';
import 'package:beyond_vision/core/core.dart';

class NewButton extends StatelessWidget {
  final bool previousPage;
  const NewButton({super.key, required this.previousPage});
  //previousPage ? 당신의 루틴 : 루틴 detail edit
  @override
  Widget build(BuildContext context) {
    return previousPage
        ? Container(
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const NewName(isExist: false));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  size: 80,
                  color: Color(fontYellowColor),
                ),
              ),
            ),
          )
        : Center(
            child: Material(
              shape: const CircleBorder(side: BorderSide.none),
              elevation: 15,
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(boxColor),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewWorkOut()),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 80,
                        color: Color(fontYellowColor),
                      ))),
            ),
          );
  }
}
