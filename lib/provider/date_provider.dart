import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  int selectedIndex = -1;

  DateProvider() {
    selectedIndex = selectedDay.weekday - 1;
  }

  void updateSelectedDay(DateTime newDay, DateTime focusedDay) {
    selectedDay = newDay;
    selectedIndex = selectedDay.weekday - 1;
    notifyListeners(); // 상태가 변경될 때마다 리스너들에게 알림
  }
}
