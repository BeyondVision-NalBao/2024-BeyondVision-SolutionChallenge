import 'package:beyond_vision/model/routine_model.dart';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoutineService {
  static const String baseUrl = "http://34.64.89.205/api/v1/exercise";

  List<Routine> routineList = [];

  Future<List<Routine>> getAllRoutine(int memberId) async {
    final url = Uri.parse('$baseUrl/routine/detail/1');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> routines =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var routine in routines) {
        routineList.add(Routine.fromJson(routine));
      }
      return routineList;
    }
    throw Error();
  }

  Future<bool> addRoutine(Routine newRoutine, int memberId) async {
    final url = Uri.https(baseUrl, '/routine/register/:$memberId');
    var response = await http.post(url, body: newRoutine);

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      routineList.add(data);
      return true;
    }
    throw Error();
  }

  Future<bool> editRoutine(Routine routine, Long memberId) async {
    final url =
        Uri.https(baseUrl, '/routine/modify/:$memberId&${routine.routineId}');
    var response = await http.post(url, body: routine);

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      routineList.add(data);
      return true;
    }
    throw Error();
  }

  Future<bool> deleteRoutine(Routine routine, Long memberId) async {
    final url =
        Uri.https(baseUrl, '/routine/delete/:$memberId&${routine.routineId}');
    var response = await http.post(url, body: routine);

    if (response.statusCode == 200) {
      routineList = [];
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      routineList.add(data);
      return true;
    }
    throw Error();
  }
}
