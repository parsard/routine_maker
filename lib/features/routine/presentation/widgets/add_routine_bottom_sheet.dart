// lib/features/routine/presentation/widgets/add_routine_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/presentation/providers/routine_providers.dart';
import 'package:routine_maker/features/routine/presentation/widgets/alarm_selector.dart';
import 'package:routine_maker/features/routine/presentation/widgets/color_selector.dart';
import 'package:routine_maker/features/routine/presentation/widgets/day_selector.dart';

class AddRoutineBottomSheet extends ConsumerStatefulWidget {
  const AddRoutineBottomSheet({super.key});

  @override
  ConsumerState<AddRoutineBottomSheet> createState() =>
      _AddRoutineBottomSheetState();
}

class _AddRoutineBottomSheetState extends ConsumerState<AddRoutineBottomSheet> {
  final _titleController = TextEditingController();
  List<bool> _selectedDays = List.filled(7, false);
  bool _isAlarmEnabled = false;
  TimeOfDay? _alarmTime;
  Color _selectedColor = Colors.blue; 

  void _saveRoutine() {
    final title = _titleController.text;
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفاً یک عنوان برای روتین وارد کنید.')),
      );
      return;
    }

    final newRoutine = RoutineEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      
      days: _convertSelectedDaysToStrings(_selectedDays),
      createdAt: DateTime.now(),
      alarmTime: _isAlarmEnabled ? _alarmTime : null,
      color: _selectedColor,
    );

    ref.read(routineNotifierProvider.notifier).addRoutine(newRoutine);
    Navigator.of(context).pop();
  }

  List<String> _convertSelectedDaysToStrings(List<bool> selected) {
    final List<String> dayNames = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    List<String> result = [];
    for(int i = 0; i < selected.length; i++) {
      if(selected[i]) {
        result.add(dayNames[i]);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _saveRoutine,
                  child: const Text('ذخیره', style: TextStyle(fontSize: 16)),
                ),
                const Text(
                  'ساخت روتین جدید',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),

            // Title Input
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'عنوان روتین',
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 24),

            // Day Selector
            DaySelector(
              onSelectionChanged: (days) {
                _selectedDays = days;
              },
            ),
            const SizedBox(height: 24),

            // Alarm Setter
            AlarmSetter(
              onAlarmChanged: (isEnabled, time) {
                setState(() {
                  _isAlarmEnabled = isEnabled;
                  _alarmTime = time;
                });
              },
            ),
            const SizedBox(height: 24),

            // Color Selector
            ColorSelector(
              onColorSelected: (color) {
                _selectedColor = color;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
