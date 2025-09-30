// lib/features/routine/presentation/notifiers/calendar_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/presentation/state/calender_state.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier() : super(CalendarState.initial());

  Jalali _findFirstDayOfWeek(Jalali date) {
    return date.addDays(-(date.weekDay - 1));
  }


  void nextWeek() {
   
    final todayWeekStart = _findFirstDayOfWeek(state.today);
    final nextWeekStart = todayWeekStart.addDays(7);
    
    state = state.copyWith(
      currentDisplayDate: nextWeekStart,
    );
  }

  void previousWeek() {
    final todayWeekStart = _findFirstDayOfWeek(state.today);
    state = state.copyWith(
      currentDisplayDate: todayWeekStart,
    );
  }


  List<Jalali> getWeekDays() {
    final firstDayOfWeek = _findFirstDayOfWeek(state.currentDisplayDate);
    return List.generate(7, (index) => firstDayOfWeek.addDays(index));
  }
  bool isToday(Jalali date) {
    return date.year == state.today.year &&
           date.month == state.today.month &&
           date.day == state.today.day;
  }

  bool isSelectedDate(Jalali date) {
   
    final firstDayOfDisplayedWeek = _findFirstDayOfWeek(state.currentDisplayDate);
    return date.year == firstDayOfDisplayedWeek.year &&
           date.month == firstDayOfDisplayedWeek.month &&
           date.day == firstDayOfDisplayedWeek.day;
  }

  bool canNavigateBack() {
   
    final currentWeekStart = _findFirstDayOfWeek(state.currentDisplayDate);
    final todayWeekStart = _findFirstDayOfWeek(state.today);
    
    return currentWeekStart.julianDayNumber != todayWeekStart.julianDayNumber;
  }
  
  bool canNavigateNext() {
    final currentWeekStart = _findFirstDayOfWeek(state.currentDisplayDate);
    final todayWeekStart = _findFirstDayOfWeek(state.today);

    return currentWeekStart.julianDayNumber == todayWeekStart.julianDayNumber;
  }
}

final calendarNotifierProvider =
    StateNotifierProvider<CalendarNotifier, CalendarState>((ref) {
  return CalendarNotifier();
});
