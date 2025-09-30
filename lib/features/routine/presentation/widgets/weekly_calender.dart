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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        children: [
          TextButton(
            
            onPressed: buttonAction,
            child: Text(buttonText),
            style: TextButton.styleFrom(
              
              backgroundColor: Colors.green,
              foregroundColor: Theme.of(context).primaryColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 16.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(7, (index) {
              final date = weekDates[index];
              final bool isToday = calendarNotifier.isToday(date);
              
              final Color backgroundColor = isToday 
                  ? Theme.of(context).primaryColor 
                  : Colors.transparent;
              final Color textColor = isToday ? Colors.white : Colors.black;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
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
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
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
