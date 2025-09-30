// lib/features/routine/presentation/widgets/weekly_calendar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routine_maker/features/routine/presentation/notifiers/calender_notifier.dart';

class WeeklyCalendar extends ConsumerWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(calendarNotifierProvider);
    final calendarNotifier = ref.read(calendarNotifierProvider.notifier);

    final weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];
    final weekDates = calendarNotifier.getWeekDays();
    final bool isCurrentWeek = calendarNotifier.isDisplayingCurrentWeek();

    final String buttonText = isCurrentWeek ? 'هفته قبل' : 'هفته بعد';
    final VoidCallback buttonAction = isCurrentWeek
        ? calendarNotifier.goToPreviousWeek
        : calendarNotifier.goToCurrentWeek;

    // A fixed width for each day column to ensure alignment with RoutineListItem
    // این عرض ثابت باعث تراز شدن عمودی ستون‌ها می‌شود
    const double dayColumnWidth = 40.0;

    return Padding(
      // We match this padding with RoutineListItem's container for perfect alignment
      // این Padding با کانتینر آیتم روتین هماهنگ است
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          // The button will take up the remaining space
          // دکمه فضای باقی‌مانده را اشغال می‌کند
          Expanded(
            child: Align(
              alignment: Alignment.centerRight, // Align button to the right
              child: TextButton(
                onPressed: buttonAction,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white, // Text color should be white on green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Rounded button
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // A fixed space between the button and the calendar dates
          // یک فاصله ثابت بین دکمه و تقویم
          const SizedBox(width: 16.0),
          // Row for the 7 days of the week
          // ردیف برای ۷ روز هفته
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(7, (index) {
              final date = weekDates[index];
              final bool isToday = calendarNotifier.isToday(date);

              final Color backgroundColor =
                  isToday ? Theme.of(context).primaryColor : Colors.transparent;
              final Color textColor = isToday ? Colors.white : Colors.black;

              // Each day is wrapped in a SizedBox with a fixed width
              // هر روز در یک SizedBox با عرض ثابت قرار می‌گیرد
              return SizedBox(
                width: dayColumnWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weekDays[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
