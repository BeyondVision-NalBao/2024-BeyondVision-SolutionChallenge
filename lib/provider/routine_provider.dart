import 'package:beyond_vision/model/routine_model.dart';
import 'package:beyond_vision/model/user_model.dart';
import 'package:flutter/material.dart';

class RoutineProvider with ChangeNotifier {
  bool isChanged = false;
  String newName = "";
  List<Routine> routines = [
    Routine(1, "매일 저녁", [
      RoutineExercise("스쿼트", 30, 1),
      RoutineExercise("런지", 30, 2),
      RoutineExercise("플랭크", 30, 3)
    ]),
    Routine(2, "하체", [
      RoutineExercise("스쿼트", 30, 1),
      RoutineExercise("런지", 30, 2),
      RoutineExercise("와이드 스쿼트", 30, 3)
    ]),
    Routine(3, "스트레칭", [
      RoutineExercise("스쿼트", 30, 1),
      RoutineExercise("런지", 30, 2),
      RoutineExercise("플랭크", 30, 3)
    ])
  ];
  int indexNum = -1;

  void getRoutine(Routine routine) {
    routines = [];
    routines.add(routine);
  }

  void addWorkout(String name, int count) {
    if (indexNum == -1) {
      //새로 생성
      routines.add(Routine(4, newName, [RoutineExercise(name, count, 1)]));
    } else {
      int order = routines[indexNum].routineDetail.length;
      routines[indexNum].routineDetail.add(RoutineExercise(name, count, order));
      indexNum = -1;
    }
  }

  void editName(int index, String newName) {
    routines[index].routineName = newName;
    newName = "";
  }

  void editOrder(int index, List<RoutineExercise> routineExercise) {
    routines[index].routineDetail = routineExercise;
  }
}
