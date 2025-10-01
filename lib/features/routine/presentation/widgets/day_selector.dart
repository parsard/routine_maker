import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  final Function(List<bool>) onSelectionChanged;

  const DaySelector({super.key, required this.onSelectionChanged});

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  // شنبه تا جمعه
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'انتخاب روزها',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_days.length, (index) {
              return GestureDetector(
                onTap: () => _toggleDay(index),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _selectedDays[index]
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  child: Text(
                    _days[index],
                    style: TextStyle(
                      color: _selectedDays[index] ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
