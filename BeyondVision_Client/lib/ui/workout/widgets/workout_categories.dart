import 'package:beyond_vision/provider/workout_provider.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_detail_box.dart';
import 'package:flutter/material.dart';
import 'package:beyond_vision/service/workout_service.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  final int cate;
  final String name;
  final bool? isRoutine;

  const Categories({
    super.key,
    required this.cate,
    required this.name,
    this.isRoutine,
  });

  @override
  Widget build(BuildContext context) {
    WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    if (cate == 0) {
      return Scaffold(
          appBar: MyAppBar(context, titleText: name),
          backgroundColor: Colors.black,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: workoutProvider.workoutTop.length,
                itemBuilder: (BuildContext context, int index) {
                  return WorkOutDetail(
                    workout: workoutProvider.workoutTop[index],
                    isRoutine: isRoutine,
                  );
                }),
          ));
    } else if (cate == 1) {
      return Scaffold(
          appBar: MyAppBar(context, titleText: name),
          backgroundColor: Colors.black,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: workoutProvider.workoutBottom.length,
                itemBuilder: (BuildContext context, int index) {
                  return WorkOutDetail(
                    workout: workoutProvider.workoutBottom[index],
                    isRoutine: isRoutine,
                  );
                }),
          ));
    } else if (cate == 2) {
      return Scaffold(
          appBar: MyAppBar(context, titleText: name),
          backgroundColor: Colors.black,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: workoutProvider.workoutCore.length,
                itemBuilder: (BuildContext context, int index) {
                  return WorkOutDetail(
                    workout: workoutProvider.workoutCore[index],
                    isRoutine: isRoutine,
                  );
                }),
          ));
    } else {
      return Scaffold(
          appBar: MyAppBar(context, titleText: name),
          backgroundColor: Colors.black,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: workoutProvider.workoutStretch.length,
                itemBuilder: (BuildContext context, int index) {
                  return WorkOutDetail(
                    workout: workoutProvider.workoutStretch[index],
                    isRoutine: isRoutine,
                  );
                }),
          ));
    }
  }
}
