import 'dart:ffi';

class Record {
  final Long recordId;
  final int? exerciseCount;
  final int? exerciseTime;
  final String exerciseName;
  final DateTime exerciseDate;

  Record(this.recordId, this.exerciseCount, this.exerciseTime,
      this.exerciseName, this.exerciseDate);

  Record.fromJson(Map<String, dynamic> json)
      : recordId = json['recordId'],
        exerciseCount = json['exerciseCount'],
        exerciseTime = json['exerciseTime'],
        exerciseName = json['exerciseName'],
        exerciseDate = json['exerciseDate'];

  Map<String, dynamic> toJson() => {
        'recordId': recordId,
        'exerciseCount': exerciseCount,
        'exerciseTime': exerciseTime,
        'exerciseName': exerciseName,
        'exerciseDate': exerciseDate,
      };
}
