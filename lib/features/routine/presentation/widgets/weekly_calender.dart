import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    const double dayColumnWidth = 40.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: buttonAction,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(7, (index) {
              final date = weekDates[index];
              final bool isToday = calendarNotifier.isToday(date);
              final bool isSelected = calendarNotifier.isSelectedDate(date); 
              Color backgroundColor;
              Color textColor;
              Border? border;

              if (isSelected) {
                backgroundColor = Theme.of(context).primaryColor;
                textColor = Colors.white;
                border = null;
              } else if (isToday) {
                backgroundColor = Colors.transparent;
                textColor = Theme.of(context).primaryColor;
                border = Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                );
              } else {
                // روزهای معمولی
                backgroundColor = Colors.transparent;
                textColor = Colors.black;
                border = null;
              }

              return SizedBox(
                width: dayColumnWidth,
                child: GestureDetector( 
                  onTap: () {
                    calendarNotifier.selectDate(date); 
                  },
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
                          border: border, 
                        ),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
