import 'package:beyond_vision/provider/routine_provider.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_routine_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routine extends StatelessWidget {
  const Routine({super.key});

  @override
  Widget build(BuildContext context) {
    RoutineProvider routineProvider = Provider.of<RoutineProvider>(context);

    return Scaffold(
      appBar: MyAppBar(context, titleText: "운동 루틴"),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: routineProvider.routines.length,
              itemBuilder: (context, index) {
                final routine = routineProvider.routines[index];
                return RoutineButton(
                  routine: routine,
                  index: index,
                );
              },
            )),
      ),
    );
  }
}
