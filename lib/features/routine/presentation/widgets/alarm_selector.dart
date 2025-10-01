// lib/features/routine/presentation/widgets/alarm_setter.dart
import 'package:flutter/material.dart';

class AlarmSetter extends StatefulWidget {
  final Function(bool, TimeOfDay?) onAlarmChanged;

  const AlarmSetter({super.key, required this.onAlarmChanged});

  @override
  State<AlarmSetter> createState() => _AlarmSetterState();
}

class _AlarmSetterState extends State<AlarmSetter> {
  bool _isAlarmEnabled = false;
  TimeOfDay? _selectedTime;

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? Container(),
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onAlarmChanged(_isAlarmEnabled, _selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'یادآور',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        Container(
          // !<-- تغییر در Padding و Decoration -->!
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // کاهش پدینگ عمودی
          decoration: BoxDecoration(
            // پس زمینه حذف و حاشیه اضافه شد
            border: Border.all(color: Colors.grey.shade400), 
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // !<-- ترتیب متن و چک‌باکس مطابق تصویر اصلاح شد -->!
              Row(
                children: [
                  const Text('یادآور'),
                  Checkbox(
                    value: _isAlarmEnabled,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAlarmEnabled = value ?? false;
                        if (_isAlarmEnabled && _selectedTime == null) {
                          _selectedTime = TimeOfDay.now();
                        }
                      });
                      widget.onAlarmChanged(_isAlarmEnabled, _selectedTime);
                    },
                  ),
                ],
              ),
              Text(
                _isAlarmEnabled && _selectedTime != null
                    ? _selectedTime!.format(context)
                    : '--:--',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isAlarmEnabled ? Colors.black : Colors.grey,
                  fontFamily: 'Vazirmatn',
                ),
              ),
              TextButton(
                onPressed: _isAlarmEnabled ? _pickTime : null,
                child: const Text('تغییر زمان'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
