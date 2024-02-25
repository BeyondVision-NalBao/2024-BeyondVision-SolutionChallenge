import 'package:beyond_vision/provider/routine_provider.dart';
import 'package:beyond_vision/ui/routine/widgets/new_routine_name.dart';
import 'package:beyond_vision/ui/routine/widgets/new_workout.dart';
import 'package:flutter/material.dart';
import 'package:beyond_vision/core/core.dart';
import 'package:provider/provider.dart';

class NewButton extends StatelessWidget {
  final bool previousPage;
  int? index;
  NewButton({super.key, required this.previousPage, this.index});
  //previousPage ? 당신의 루틴 : 루틴 detail edit
  @override
  Widget build(BuildContext context) {
    RoutineProvider routineProvider = Provider.of<RoutineProvider>(context);
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
                            NewName(isExist: false));
                  } else {
                    if (index != null) {
                      routineProvider.indexNum = index!;
                    }
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
