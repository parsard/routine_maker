// lib/features/routine/presentation/widgets/weekly_calendar.dart
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
    
    final canGoBack = calendarNotifier.canNavigateBack();
    final canGoNext = calendarNotifier.canNavigateNext();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: canGoNext ? null : Colors.grey.withOpacity(0.3),
            ),
            onPressed: canGoNext ? calendarNotifier.nextWeek : null,
          ),
          ...List.generate(7, (index) {
            final date = weekDates[index];
            
            
            final bool today = calendarNotifier.isToday(date);
            
            final bool isSelected = false; 
            final Color? backgroundColor;
            final Color textColor;
            final FontWeight fontWeight;

            if (today) {
              backgroundColor = Theme.of(context).primaryColor; 
              textColor = Colors.white;
              fontWeight = FontWeight.bold; 
            } else {
              backgroundColor = Colors.transparent;
              textColor = Colors.black;
              fontWeight = FontWeight.normal;
            }

            return Column(
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: today && !isSelected 
                        ? Border.all(color: Theme.of(context).primaryColor, width: 1.5) 
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ],
            );
          }),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: canGoBack ? null : Colors.grey.withOpacity(0.3),
            ),
            onPressed: canGoBack ? calendarNotifier.previousWeek : null,
          ),
        ],
      ),
    );
  }
}
