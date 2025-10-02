// lib/features/routine/presentation/widgets/add_routine_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/presentation/providers/routine_providers.dart';
import 'package:routine_maker/features/routine/presentation/widgets/alarm_selector.dart';
import 'package:routine_maker/features/routine/presentation/widgets/color_selector.dart';
import 'package:routine_maker/features/routine/presentation/widgets/frequency_selector.dart';

class AddRoutineBottomSheet extends ConsumerStatefulWidget {
  const AddRoutineBottomSheet({super.key});

  @override
  ConsumerState<AddRoutineBottomSheet> createState() =>
      _AddRoutineBottomSheetState();
}

class _AddRoutineBottomSheetState extends ConsumerState<AddRoutineBottomSheet> {
  final _titleController = TextEditingController();
  bool _isAlarmEnabled = false;
  TimeOfDay? _alarmTime;
  Color _selectedColor = Colors.blue;
  int _targetRepetitions = 3;

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
      createdAt: DateTime.now(),
      alarmTime: _isAlarmEnabled ? _alarmTime : null,
      color: _selectedColor,
      targetRepetitionsPerWeek: _targetRepetitions,
    );

    ref.read(routineNotifierProvider.notifier).addRoutine(newRoutine);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _saveRoutine,
                  child: const Text(
                    'ذخیره',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'روتین جدید',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Input
                  _buildSectionContainer(
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'عنوان روتین',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Frequency Selector
                  _buildSectionContainer(
                    child: FrequencySelector(
                      initialFrequency: _targetRepetitions,
                      onFrequencyChanged: (frequency) {
                        setState(() {
                          _targetRepetitions = frequency;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Alarm Setter
                  _buildSectionContainer(
                    child: AlarmSetter(
                      onAlarmChanged: (isEnabled, time) {
                        setState(() {
                          _isAlarmEnabled = isEnabled;
                          _alarmTime = time;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Color Selector
                  _buildSectionContainer(
                    child: ColorSelector(
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}