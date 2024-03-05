import 'package:beyond_vision/model/routine_model.dart';
import 'package:beyond_vision/service/routine_service.dart';
import 'package:flutter/material.dart';

class RoutineProvider with ChangeNotifier {
  bool isWorkout = false;
  bool isChanged = false;
  String newName = "";
  List<Routine> routines = [];
  Routine newRoutine = Routine(null, "", []);
  int indexNum = -1;
  RoutineService routineService = RoutineService();

  void getRoutine(List<Routine> routine) {
    routines = routine;
  }

  void addWorkout(String name, int count, int memberId) {
    if (indexNum == -1) {
      //새로 생성
      routineService.addRoutine(
          Routine(null, newName, [RoutineExercise(null, name, count, 1)]),
          memberId);
      routines
          .add(Routine(null, newName, [RoutineExercise(null, name, count, 1)]));
    } else {
      int order = routines[indexNum].routineDetails.length;

      routines[indexNum]
          .routineDetails
          .add(RoutineExercise(null, name, count, order));
      routineService.editRoutine(routines[indexNum], memberId);

      indexNum = -1;
    }
  }

  void editName(int index, String newName) {
    routines[index].routineName = newName;
    newName = "";
  }

  void editOrder(
      int index, List<RoutineExercise> routineExercise, int memberId) {
    for (int i = 0; i < routineExercise.length; i++) {
      routineExercise[i].exerciseOrder = i + 1;
    }
    routines[index].routineDetails = routineExercise;
    routineService.editRoutine(routines[index], memberId);
  }

  void deleteRoutine(int index) {
    try {
      // index가 유효한지 확인
      if (index >= 0 && index < routines.length) {
        // 해당 인덱스의 루틴을 삭제합니다.
        routines.removeAt(index);
      }
    } catch (e) {}
  }
}
