import 'package:flutter/material.dart';
import 'package:beyond_vision/model/record_model.dart';
import 'package:table_calendar/table_calendar.dart';

class DateProvider extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  int selectedIndex = -1;
  double todayExerciseTime = 0.0;
  List<double> thisWeekExerciseTime = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  List<Record> records = [];
  List<List<Record>> thisWeek = [];
  List<Record> todayRecords = [];

  DateProvider() {
    selectedIndex = selectedDay.weekday - 1;
    updateSelectedDay(selectedDay, selectedDay);
  }

  void getRecord(List<Record> newRecords) {
    records = newRecords;
  }

  void moveWeek(DateTime newDay) {
    selectedDay = newDay;
    updateSelectedDay(selectedDay, selectedDay);
  }

  void updateSelectedDay(DateTime newDay, DateTime focusedDay) {
    thisWeek = [];
    todayRecords = [];
    todayExerciseTime = 0.0;
    thisWeekExerciseTime = [];
    selectedDay = newDay;
    selectedIndex = selectedDay.weekday - 1;

    //오늘 기록
    todayRecords = records
        .where((record) => isSameDay(record.exerciseDate, selectedDay))
        .toList();

    for (int i = 0; i < todayRecords.length; i++) {
      todayExerciseTime += todayRecords[i].exerciseTime!;
    }

    //이번주 기록
    int mondayOffset = selectedDay.weekday - DateTime.monday;
    DateTime newDate = selectedDay.subtract(Duration(days: mondayOffset));

    for (int i = 0; i < 7; i++) {
      List<Record> record = [];
      DateTime currentDate = newDate.add(Duration(days: i));
      record = records
          .where((record) => isSameDay(record.exerciseDate, currentDate))
          .toList();
      if (record.isEmpty) {
        thisWeek.add([Record(null, null, null, null, currentDate)]);
      } else {
        thisWeek.add(record);
      }
    }

    for (int i = 0; i < thisWeek.length; i++) {
      double sum = 0.0;
      for (int j = 0; j < thisWeek[i].length; j++) {
        if (thisWeek[i][j].exerciseTime != null) {
          sum += thisWeek[i][j].exerciseTime!;
        }
      }
      thisWeekExerciseTime.add(sum);
    }
    notifyListeners(); // 상태가 변경될 때마다 리스너들에게 알림
  }
}
