import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
class WeeklyCalendar extends StatefulWidget {
  const WeeklyCalendar({super.key});

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  late Jalali _currentDisplayDate;
  late final Jalali _today; 

  @override
  void initState() {
    super.initState();
    final now = Jalali.now();
    _currentDisplayDate =    now;
    _today = now;
  }

  Jalali _findFirstDayOfWeek(Jalali date) {
    return date.addDays(-(date.weekDay - 1));
  }

  void _nextWeek() {
    setState(() {
      _currentDisplayDate = _currentDisplayDate.addDays(7);
    });
  }

  void _previousWeek() {

    final targetWeekStartDate = _findFirstDayOfWeek(_currentDisplayDate).addDays(-7);
    final initialWeekStartDate = _findFirstDayOfWeek(_today);
    if (targetWeekStartDate.julianDayNumber >= initialWeekStartDate.julianDayNumber) {
      setState(() {
        _currentDisplayDate = _currentDisplayDate.addDays(-7);
      });
   
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: _nextWeek, 
          ),
          ...List.generate(7, (index) {
            return Column(
              children: [
                Text(
                  weekDays[index],
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _currentDisplayDate.weekDay == (index + 1) % 7 ? Theme.of(context).primaryColor : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${_currentDisplayDate.addDays(index - (_currentDisplayDate.weekDay - 1)).day}',
                    style: TextStyle(
                      color: _currentDisplayDate.weekDay == (index + 1) % 7 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: _previousWeek, 
          ),
        ],
      ),
    );
  }
}
