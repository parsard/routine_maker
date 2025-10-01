// lib/features/routine/presentation/widgets/day_selector.dart
import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  final Function(List<bool>) onSelectionChanged;

  const DaySelector({super.key, required this.onSelectionChanged});

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  final List<String> _days = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];
  final List<bool> _selectedDays = List.filled(7, false);

  void _toggleDay(int index) {
    setState(() {
      _selectedDays[index] = !_selectedDays[index];
    });
    widget.onSelectionChanged(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment را به stretch تغییر می‌دهیم تا عنوان هم هم‌راستا باشد
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // عنوان ویجت
        const Text(
          'انتخاب روزها',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.right, // متن را راست‌چین می‌کنیم
        ),
        const SizedBox(height: 8),

        // !<-- تغییر اصلی اینجاست: اضافه کردن Container -->!
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_days.length, (index) {
                return GestureDetector(
                  onTap: () => _toggleDay(index),
                  child: CircleAvatar(
                    radius: 18, // کمی کوچک‌تر برای جا شدن بهتر
                    backgroundColor: _selectedDays[index]
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200], // رنگ غیرفعال کمی روشن‌تر
                    child: Text(
                      _days[index],
                      style: TextStyle(
                        color:
                            _selectedDays[index] ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
