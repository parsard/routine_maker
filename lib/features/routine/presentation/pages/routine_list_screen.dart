import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
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
                _showAddRoutineBottomSheet(context, ref);
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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'خطا: ${state.errorMessage}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(routineNotifierProvider.notifier).fetchAllRoutines();
                },
                child: const Text('تلاش مجدد'),
              ),
            ],
          ),
        );
        
      case RoutineStatus.success:
        if (state.routines.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_note,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'هنوز روتینی اضافه نکرده‌اید',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => _showAddRoutineBottomSheet(context, ref),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('افزودن اولین روتین'),
                ),
              ],
            ),
          );
        }
        
        // ⬅️ راه‌حل: استفاده از ListView.separated با addAutomaticKeepAlives
        return ListView.separated(
          key: ValueKey('routine_list_${state.routines.length}'), // ⬅️ کلید پویا
          addAutomaticKeepAlives: false, // ⬅️ غیرفعال کردن keep alive
          addRepaintBoundaries: false,   // ⬅️ غیرفعال کردن repaint boundaries
          itemCount: state.routines.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final routine = state.routines[index];
            return RoutineListItem(
              key: ValueKey('${routine.id}_${routine.completedRepetitionsThisWeek}'), // ⬅️ کلید پیچیده‌تر
              routine: routine,
              onDelete: () {
                _showDeleteConfirmation(context, ref, routine);
              },
              onEdit: () {
                _showEditRoutineBottomSheet(context, ref, routine);
              },
              
            );
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    RoutineEntity routine,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف روتین'),
        content: Text('آیا مطمئن هستید که می‌خواهید "${routine.title}" را حذف کنید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لغو'),
          ),
          TextButton(
            onPressed: () {
              ref.read(routineNotifierProvider.notifier).deleteRoutine(routine.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showEditRoutineBottomSheet(
    BuildContext context,
    WidgetRef ref,
    RoutineEntity routine,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const AddRoutineBottomSheet(
          // routineToEdit: routine,
        );
      },
    );
  }

  void _showAddRoutineBottomSheet(BuildContext context, WidgetRef ref) {
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
}
