import 'package:beyond_vision/model/routine_model.dart';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoutineService {
  static const String baseUrl = "/api/v1/exercise";

  late List<Routine> _routineList;
  List<Routine> get routineList => _routineList;

  Future<List<Routine>> getAllRoutine(Long memberId) async {
    final url = Uri.https(baseUrl, '/routine/detail/:memberId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> routines = jsonDecode(response.body);
      for (var routine in routines) {
        _routineList.add(Routine.fromJson(routine));
      }
      return _routineList;
    }
    throw Error();
  }

  Future<bool> addRoutine(Routine newRoutine, Long memberId) async {
    final url = Uri.https(baseUrl, '/routine/register/:$memberId');
    var response = await http.post(url, body: newRoutine);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _routineList.add(data);
      return true;
    }
    throw Error();
  }

  Future<bool> editRoutine(Routine routine, Long memberId) async {
    final url =
        Uri.https(baseUrl, '/routine/modify/:$memberId&${routine.routineId}');
    var response = await http.post(url, body: routine);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //_routineList.add(data);
      return true;
    }
    throw Error();
  }
}
