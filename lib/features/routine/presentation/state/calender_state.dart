import 'package:shamsi_date/shamsi_date.dart';

class CalendarState {
  final Jalali currentDisplayDate;
  final Jalali today;
  final Jalali selectedDate;
  const CalendarState({
    required this.currentDisplayDate,
    required this.today,
    required this.selectedDate,
  });

  factory CalendarState.initial() {
    final now = Jalali.now();
    return CalendarState(
      currentDisplayDate: now,
      today: now,
      selectedDate: now,
    );
  }

  CalendarState copyWith({
    Jalali? currentDisplayDate,
    Jalali? today,
    Jalali? selectedDate,
  }) {
    return CalendarState(
      currentDisplayDate: currentDisplayDate ?? this.currentDisplayDate,
      today: today ?? this.today,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
