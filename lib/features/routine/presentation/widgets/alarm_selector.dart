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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
         const Text(
          'یادآور',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _isAlarmEnabled ? _pickTime : null,
                child: const Text('تغییر زمان'),
              ),
              Text(
                _isAlarmEnabled && _selectedTime != null
                    ? _selectedTime!.format(context)
                    : '--:--',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isAlarmEnabled ? Colors.black : Colors.grey,
                ),
              ),
              Row(
                children: [
                  const Text('فعال کردن یادآور'),
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
            ],
          ),
        ),
      ],
    );
  }
}
