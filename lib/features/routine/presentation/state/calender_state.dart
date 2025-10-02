import 'package:shamsi_date/shamsi_date.dart';

class CalendarState {
  final Jalali currentDisplayDate;
  final Jalali today;
  const CalendarState({
    required this.currentDisplayDate,
    required this.today,
  });

  factory CalendarState.initial() {
    final now = Jalali.now();
    return CalendarState(
      currentDisplayDate: now,
      today: now,
    );
  }

  CalendarState copyWith({
    Jalali? currentDisplayDate,
    Jalali? today,
  }) {
    return CalendarState(
      currentDisplayDate: currentDisplayDate ?? this.currentDisplayDate,
      today: today ?? this.today,
    );
  }
}
