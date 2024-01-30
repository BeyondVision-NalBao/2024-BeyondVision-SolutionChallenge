class DateService {
  int convertDateToInt(DateTime selectedDay) {
    return selectedDay.weekday - 1;
  }
}
