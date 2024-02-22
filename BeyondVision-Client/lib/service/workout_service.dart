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

  Future<WorkOut> getRandom() async {
    final url = Uri.parse('$baseUrl/random');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));
      WorkOut randomWorkout = WorkOut.fromJson(data);

      return randomWorkout;
    }
    throw Error();
  }

  // Future<void> postReady() async {
  //   final url = Uri.parse('$baseUrl/1/ready');

  //   var response = await http.post(url,
  //       headers: {"Content-Type": "application/json; charset=UTF-8"},
  //       body: json.encode({"routineName": "멋지게 살자"}));

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(utf8.decode(response.bodyBytes));
  //     postStart();
  //   }
  //   throw Error();
  // }

  // Future<void> postStart() async {
  //   final url = Uri.parse('$baseUrl/1/1/1/start');

  //   var response = await http.post(url);
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(utf8.decode(response.bodyBytes));
  //   }
  //   throw Error();
  // }
}
