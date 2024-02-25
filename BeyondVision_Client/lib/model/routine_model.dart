class RoutineExercise {
  final int? id;
  final String exerciseName;
  final int exerciseCount;
  late int exerciseOrder;

  RoutineExercise(
      this.id, this.exerciseName, this.exerciseCount, this.exerciseOrder);

  RoutineExercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        exerciseName = json['exerciseName'],
        exerciseCount = json['exerciseCount'],
        exerciseOrder = json['exerciseOrder'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseName': exerciseName,
        'exerciseCount': exerciseCount,
        'exerciseOrder': exerciseOrder,
      };
}

class Routine {
  final int? routineId;
  late String routineName;
  late List<RoutineExercise> routineDetails;

  Routine(this.routineId, this.routineName, this.routineDetails);

  Routine.fromJson(Map<String, dynamic> json)
      : routineId = json['routineId'],
        routineName = json['routineName'],
        routineDetails = (json['routineDetails'] as List)
            .map((detail) => RoutineExercise.fromJson(detail))
            .toList();

  Map<String, dynamic> toJson() => {
        'routineId': routineId,
        'routineName': routineName,
        'routineDetail': routineDetails,
      };
}
