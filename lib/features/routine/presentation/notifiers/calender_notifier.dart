// lib/features/routine/presentation/notifiers/calendar_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/presentation/state/calender_state.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier() : super(CalendarState.initial());

  Jalali _findFirstDayOfWeek(Jalali date) {
    return date.addDays(-(date.weekDay - 1));
  }

  void goToPreviousWeek() {
    final todayWeekStart = _findFirstDayOfWeek(state.today);
    final previousWeekStart = todayWeekStart.addDays(-7);
    
    state = state.copyWith(
      currentDisplayDate: previousWeekStart,
    );
  }

  void goToCurrentWeek() {
    final todayWeekStart = _findFirstDayOfWeek(state.today);
    state = state.copyWith(
      currentDisplayDate: todayWeekStart,
      selectedDate: state.today, 
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

  bool isDisplayingCurrentWeek() {
    final currentWeekStart = _findFirstDayOfWeek(state.currentDisplayDate);
    final todayWeekStart = _findFirstDayOfWeek(state.today);
    return currentWeekStart.julianDayNumber == todayWeekStart.julianDayNumber;
  }

  // ⬅️ متدهای جدید برای انتخاب روز
  void selectDate(Jalali date) {
    state = state.copyWith(selectedDate: date);
  }

  bool isSelectedDate(Jalali date) {
    return date.year == state.selectedDate.year &&
           date.month == state.selectedDate.month &&
           date.day == state.selectedDate.day;
  }

  Jalali getSelectedDate() {
    return state.selectedDate;
  }

  String getSelectedDayName() {
    final persianDays = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنج‌شنبه', 'جمعه'];
    final weekDay = state.selectedDate.weekDay;
    return persianDays[weekDay == 7 ? 0 : weekDay];
  }
}

final calendarNotifierProvider =
    StateNotifierProvider<CalendarNotifier, CalendarState>((ref) {
  return CalendarNotifier();
});
