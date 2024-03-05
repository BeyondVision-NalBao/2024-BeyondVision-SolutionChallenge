import 'package:beyond_vision/model/routine_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoutineService {
  static const String baseUrl = "http://34.64.89.205/api/v1/exercise";

  List<Routine> routineList = [];

  Future<List<Routine>> getAllRoutine(int memberId) async {
    final url = Uri.parse('$baseUrl/routine/detail/$memberId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> routines =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var routine in routines) {
        List<RoutineExercise> routineExercises = [];
        for (var detail in routine['routineDetails']) {
          RoutineExercise exercise = RoutineExercise.fromJson(detail);
          routineExercises.add(exercise);
        }
        Routine newRoutine = Routine(
          routine['routineId'],
          routine['routineName'],
          routineExercises,
        );
        routineList.add(newRoutine);
      }

      return routineList;
    }
    throw Error();
  }

  //새로운 루틴 생성
  Future<bool> addRoutine(Routine newRoutine, int memberId) async {
    final url = Uri.parse('$baseUrl/routine/register/$memberId');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          'routineName': newRoutine.routineName,
          'routineDetails': [
            {
              'exerciseName': newRoutine.routineDetails[0].exerciseName,
              'exerciseCount': newRoutine.routineDetails[0].exerciseCount,
              'exerciseOrder': newRoutine.routineDetails[0].exerciseOrder,
            }
          ]
        }));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<RoutineExercise> routineExercises = [];
      // 루틴에 속하는 운동들을 파싱합니다.
      for (var detail in data['routineDetails']) {
        RoutineExercise exercise = RoutineExercise.fromJson(detail);
        routineExercises.add(exercise);
      }
      Routine newRoutine = Routine(
        data['routineId'],
        data['routineName'],
        routineExercises,
      );
      routineList.add(newRoutine);
      return true;
    }
    return false;
  }

  Future<bool> editRoutine(Routine routine, int memberId) async {
    final url =
        Uri.parse('$baseUrl/routine/modify/$memberId/${routine.routineId}');

    // List<Map<String, dynamic>> details = [];
    // for (var detail in routine.routineDetail) {
    //   details.add({
    //     'exerciseName': detail.exerciseName,
    //     'exerciseCount': detail.exerciseCount,
    //     'exerciseOrder': detail.exerciseOrder,
    //   });
    // }
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: json.encode({
        'routineName': routine.routineName,
        'routineDetails': routine.routineDetails,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<RoutineExercise> routineExercises = [];
      // 루틴에 속하는 운동들을 파싱합니다.
      for (var detail in data['routineDetails']) {
        RoutineExercise exercise = RoutineExercise.fromJson(detail);
        routineExercises.add(exercise);
      }
      Routine newRoutine = Routine(
        data['routineId'],
        data['routineName'],
        routineExercises,
      );
      routineList.map((oldRoutine) {
        if (oldRoutine.routineId == newRoutine.routineId) {
          return newRoutine;
        } else {
          return oldRoutine;
        }
      }).toList();

      return true;
    }
    throw Error();
  }

  Future<bool> deleteRoutine(Routine routine, int memberId) async {
    final url =
        Uri.parse('$baseUrl/routine/delete/$memberId/${routine.routineId}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    }
    throw Error();
  }
}
