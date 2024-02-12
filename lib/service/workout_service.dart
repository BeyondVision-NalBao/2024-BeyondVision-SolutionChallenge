import 'package:beyond_vision/model/workout_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkOutService {
  static const String baseUrl = "/api/v1/exercise";

  Future<List<WorkOut>> getAllWorkOut(int categoryMember) async {
    List<WorkOut> workoutInstances = [];
    final url = Uri.https(baseUrl, '/detail:$categoryMember');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> workouts = jsonDecode(response.body);
      for (var workout in workouts) {
        workoutInstances.add(WorkOut.fromJson(workout));
      }
      return workoutInstances;
    }
    throw Error();
  }
}
