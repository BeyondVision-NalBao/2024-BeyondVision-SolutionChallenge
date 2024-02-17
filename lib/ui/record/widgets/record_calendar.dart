import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/model/record_model.dart';
import 'package:beyond_vision/provider/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    DateProvider provider = Provider.of<DateProvider>(context);
    DateTime selectedDay = provider.selectedDay;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TableCalendar(
        daysOfWeekStyle:
            const DaysOfWeekStyle(weekdayStyle: TextStyle(color: Colors.white)),
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          weekendTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          selectedDecoration: BoxDecoration(
              color: Color(fontYellowColor), shape: BoxShape.circle),
          selectedTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          todayTextStyle: TextStyle(
            color: Color(fontYellowColor),
            fontSize: 20,
          ),
          todayDecoration: BoxDecoration(color: Colors.black),
        ),
        daysOfWeekHeight: 28.0,
        startingDayOfWeek: StartingDayOfWeek.monday,
        focusedDay: selectedDay,
        firstDay: DateTime(2023, 1, 1),
        lastDay: DateTime(2024, 4, 1),
        calendarFormat: CalendarFormat.week,
        onDaySelected: provider.updateSelectedDay,
        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
        headerStyle: const HeaderStyle(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
        locale: 'ko-KR',
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            switch (day.weekday) {
              case 1:
                return const Center(
                  child: Text(
                    '월',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              case 2:
                return const Center(
                  child: Text(
                    '화',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              case 3:
                return const Center(
                  child: Text(
                    '수',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              case 4:
                return const Center(
                  child: Text(
                    '목',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              case 5:
                return const Center(
                  child: Text(
                    '금',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              case 6:
                return const Center(
                  child: Text(
                    '토',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              case 7:
                return const Center(
                  child: Text(
                    '일',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
            }
            return null;
          },
        ),
      ),
    );
  }
}
