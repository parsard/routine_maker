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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'یادآور',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              textAlign: TextAlign.right,
            ),
            Switch(
              value: _isAlarmEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isAlarmEnabled = value;
                  if (_isAlarmEnabled && _selectedTime == null) {
                    _selectedTime = TimeOfDay.now();
                  }
                });
                widget.onAlarmChanged(_isAlarmEnabled, _selectedTime);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Time Display
        InkWell(
          onTap: _isAlarmEnabled ? _pickTime : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: _isAlarmEnabled ? Colors.white : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isAlarmEnabled
                    ? Theme.of(context).primaryColor.withOpacity(0.3)
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.access_time,
                  color: _isAlarmEnabled
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  size: 20,
                ),
                Text(
                  _isAlarmEnabled && _selectedTime != null
                      ? _selectedTime!.format(context)
                      : '--:--',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isAlarmEnabled ? Colors.black87 : Colors.grey,
                    fontFamily: 'Vazirmatn',
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    _isAlarmEnabled ? 'تغییر' : 'غیرفعال',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isAlarmEnabled
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}