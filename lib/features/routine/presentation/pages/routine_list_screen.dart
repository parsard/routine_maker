// lib/features/routine/presentation/screens/routine_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/presentation/notifiers/calender_notifier.dart';
import 'package:routine_maker/features/routine/presentation/providers/routine_providers.dart';
import 'package:routine_maker/features/routine/presentation/state/routine_state.dart';
import 'package:routine_maker/features/routine/presentation/widgets/app_header.dart';
import 'package:routine_maker/features/routine/presentation/widgets/routine_list_item.dart';
import 'package:routine_maker/features/routine/presentation/widgets/weekly_calender.dart';
import 'package:routine_maker/features/routine/presentation/widgets/add_routine_bottom_sheet.dart';

class RoutineListScreen extends ConsumerWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routineNotifierProvider);
    ref.watch(calendarNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onAddPressed: () {
                _showAddRoutineBottomSheet(context);
              },
            ),
            const WeeklyCalendar(),
            const SizedBox(height: 10),
            Expanded(
              child: _buildBody(context, ref, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, RoutineState state) {
    switch (state.status) {
      case RoutineStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case RoutineStatus.failure:
        return Center(child: Text('خطا: ${state.errorMessage}'));
      case RoutineStatus.success:
        final calendarNotifier = ref.read(calendarNotifierProvider.notifier);
        final selectedDayName = calendarNotifier.getSelectedDayName();
        final selectedDate = calendarNotifier.getSelectedDate();

        final filteredRoutines = state.routines.where((routine) {
          return routine.days.contains(selectedDayName);
        }).toList();

        if (filteredRoutines.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'هیچ روتینی برای $selectedDayName',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredRoutines.length,
          itemBuilder: (context, index) {
            final routine = filteredRoutines[index];
            return RoutineListItem(
              title: routine.title,
              // color: routine.color,
              onDelete: () {
                ref
                    .read(routineNotifierProvider.notifier)
                    .deleteRoutine(routine.id);
              },
              onEdit: () {
                // TODO: منطق ویرایش
              },
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showAddRoutineBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const AddRoutineBottomSheet();
      },
    );
  }

  // ⬅️ تابع کمکی برای نام ماه
  String _getMonthName(int month) {
    const months = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند'
    ];
    return months[month - 1];
  }
}
