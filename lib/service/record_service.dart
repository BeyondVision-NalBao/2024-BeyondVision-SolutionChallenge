import 'package:beyond_vision/model/record_model.dart';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecordService {
  static const String baseUrl = "/api/v1/exercise";

  late List<Record> _recordList;
  List<Record> get recordList => _recordList;

  Future<List<Record>> getAllRecord(Long memberId) async {
    final url = Uri.https(baseUrl, '/record:$memberId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> records = jsonDecode(response.body);
      for (var record in records) {
        _recordList.add(Record.fromJson(record));
      }
      return _recordList;
    }
    throw Error();
  }

  Future<bool> addRecord(
      Record newRecord, Long exerciseId, Long memberId) async {
    final url = Uri.https(baseUrl, '/record/:$exerciseId');
    var response = await http.post(url, body: {
      'exerciseTime': newRecord.exerciseTime,
      'exerciseCount': newRecord.exerciseCount,
      'memberId': memberId
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _recordList.add(data);
      return true;
    }
    throw Error();
  }
}
