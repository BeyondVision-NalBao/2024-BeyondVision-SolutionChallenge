import 'dart:ffi';

class RoutineExercise {
  final String exerciseName;
  final int exerciseCount;
  final int exerciseOrder;

  RoutineExercise(this.exerciseName, this.exerciseCount, this.exerciseOrder);

  RoutineExercise.fromJson(Map<String, dynamic> json)
      : exerciseName = json['exerciseName'],
        exerciseCount = json['exerciseCount'],
        exerciseOrder = json['exerciseOrder'];

  Map<String, dynamic> toJson() => {
        'exerciseName': exerciseName,
        'exerciseCount': exerciseCount,
        'exerciseOrder': exerciseOrder,
      };
}

class Routine {
  final int routineId;
  final String routineName;
  final List<RoutineExercise> routineDetail;

  Routine(this.routineId, this.routineName, this.routineDetail);

  Routine.fromJson(Map<String, dynamic> json)
      : routineId = json['routineId'],
        routineName = json['routineName'],
        routineDetail = (json['routineDetail'] as List)
            .map((detail) => RoutineExercise.fromJson(detail))
            .toList();

  Map<String, dynamic> toJson() => {
        'routineId': routineId,
        'routineName': routineName,
        'routineDetail': routineDetail,
      };
}
