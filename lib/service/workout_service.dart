import 'package:beyond_vision/model/workout_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkOutService {
  static const String baseUrl = "http://34.64.89.205/api/v1/exercise";

  Future<List<WorkOut>> getAllWorkOut(int categoryNumber) async {
    List<WorkOut> workoutInstances = [];
    final url = Uri.parse('$baseUrl/detail/$categoryNumber');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> workouts =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var workout in workouts) {
        workoutInstances.add(WorkOut.fromJson(workout));
      }
      return workoutInstances;
    }
    throw Error();
  }
}
