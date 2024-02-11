import 'dart:ffi';

class RoutineDetail {
  final String exerciseName;
  final int exerciseCount;
  final int exerciseOrder;

  RoutineDetail(this.exerciseName, this.exerciseCount, this.exerciseOrder);

  RoutineDetail.fromJson(Map<String, dynamic> json)
      : exerciseName = json['exerciseName'],
        exerciseCount = json['exerciseCount'],
        exerciseOrder = json['exerciseOrder'];

  Map<String, dynamic> toJson() => {
        'exerciseName': exerciseName,
        'exerciseCount': exerciseCount,
        'exerciseOrder': exerciseOrder,
      };
}

class WorkOut {
  final Long routineId;
  final String routineName;
  final List<RoutineDetail> routineDetail;

  WorkOut(this.routineId, this.routineName, this.routineDetail);

  WorkOut.fromJson(Map<String, dynamic> json)
      : routineId = json['routineId'],
        routineName = json['routineName'],
        routineDetail = (json['routineDetail'] as List)
            .map((detail) => RoutineDetail.fromJson(detail))
            .toList();

  Map<String, dynamic> toJson() => {
        'routineId': routineId,
        'routineName': routineName,
        'routineDetail': routineDetail,
      };
}
