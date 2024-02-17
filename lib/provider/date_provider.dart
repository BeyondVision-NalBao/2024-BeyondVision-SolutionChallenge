import 'package:flutter/material.dart';
import 'package:beyond_vision/model/record_model.dart';
import 'package:table_calendar/table_calendar.dart';

class DateProvider extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  int selectedIndex = -1;
  int todayExerciseTime = 0;
  List<int> thisWeekExerciseTime = [
    0,
  ];
  DateProvider dateProvider = DateProvider();
  List<Record> records = [
    Record(1, null, 30, "숄더프레스", DateTime.now()),
    Record(2, 30, 45, "프론트레이즈", DateTime.now()),
    Record(3, null, 30, "레터럴레이즈", DateTime.now()),
    Record(4, null, 30, "스쿼트", DateTime.parse('2024-02-11')),
    Record(5, null, 30, "스쿼트", DateTime.parse('2024-02-11')),
    Record(6, null, 30, "스쿼트", DateTime.parse('2024-02-11')),
    Record(7, null, 30, "스쿼트", DateTime.parse('2024-02-17')),
    Record(8, null, 30, "스쿼트", DateTime.parse('2024-02-17')),
    Record(9, null, 30, "스쿼트", DateTime.parse('2024-02-17')),
  ];
  List<List<Record>> thisWeek = [];
  List<Record> todayRecords = [];

  DateProvider() {
    selectedIndex = selectedDay.weekday - 1;
  }

  void getRecord(List<Record> newRecords) {
    records = newRecords;
  }

  void updateSelectedDay(DateTime newDay, DateTime focusedDay) {
    selectedDay = newDay;
    selectedIndex = selectedDay.weekday - 1;

    //오늘 기록

    todayRecords = records
        .where((record) => isSameDay(record.exerciseDate, selectedDay))
        .toList();

    for (int i = 0; i < todayRecords.length; i++) {
      todayExerciseTime += todayRecords[i].exerciseTime;
    }

    //이번주 기록
    int mondayOffset = selectedDay.weekday - DateTime.monday;
    DateTime newDate = selectedDay.subtract(Duration(days: mondayOffset));

    for (int i = 0; i < 7; i++) {
      List<Record> record = records
          .where((record) =>
              isSameDay(record.exerciseDate, newDate.add(Duration(days: i))))
          .toList();
      thisWeek.add(record);
    }

    for (int i = 0; i < thisWeek.length; i++) {
      int sum = 0;
      for (int j = 0; j < thisWeek[i].length; j++) {
        sum += thisWeek[i][j].exerciseTime;
      }
      thisWeekExerciseTime.add(sum);
    }
    //notifyListeners(); // 상태가 변경될 때마다 리스너들에게 알림
  }
}
