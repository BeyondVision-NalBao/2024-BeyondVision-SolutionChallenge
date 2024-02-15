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
    return Center(
      child: Material(
        shape: const CircleBorder(side: BorderSide.none),
        elevation: 15,
        child: CircleAvatar(
            radius: 50,
            backgroundColor: const Color(boxColor),
            child: IconButton(
                onPressed: () {
                  if (previousPage) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const NewName(isExist: false));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewWorkOut()),
                    );
                  }
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
