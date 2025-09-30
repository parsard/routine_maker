// lib/features/routine/presentation/screens/routine_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/presentation/providers/routine_providers.dart'; // فایل Provider های شما
import 'package:routine_maker/features/routine/presentation/state/routine_state.dart';
import 'package:routine_maker/features/routine/presentation/widgets/app_header.dart';
import 'package:routine_maker/features/routine/presentation/widgets/routine_list_item.dart';
import 'package:routine_maker/features/routine/presentation/widgets/weekly_calender.dart';

class RoutineListScreen extends ConsumerWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routineNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. هدر سفارشی
            AppHeader(
              onAddPressed: () {
                _showAddRoutineDialog(context, ref);
              },
            ),
            // 2. تقویم هفتگی
            const WeeklyCalendar(),
            const SizedBox(height: 10),
            // 3. لیست روتین‌ها
            Expanded(
              child: _buildBody(context, ref, state),
            ),
          ],
        ),
      ),
    );
  }

  // متد برای نمایش بدنه بر اساس وضعیت
  Widget _buildBody(BuildContext context, WidgetRef ref, RoutineState state) {
    switch (state.status) {
      case RoutineStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case RoutineStatus.failure:
        return Center(child: Text('خطا: ${state.errorMessage}'));
      case RoutineStatus.success:
        if (state.routines.isEmpty) {
          return const Center(child: Text('هنوز روتینی اضافه نکرده‌اید.'));
        }
        return ListView.builder(
          itemCount: state.routines.length,
          itemBuilder: (context, index) {
            final routine = state.routines[index];
            return RoutineListItem(
              title: routine.title,
              onDelete: () {
                ref.read(routineNotifierProvider.notifier).deleteRoutine(routine.id);
              },
              onEdit: () {
                // TODO: منطق ویرایش را اینجا پیاده‌سازی کنید (مثلا نمایش یک دیالوگ مشابه افزودن)
              },
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // دیالوگ برای افزودن روتین جدید
  void _showAddRoutineDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('افزودن روتین جدید'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'عنوان روتین'),
            textAlign: TextAlign.right, // برای ورودی فارسی
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('لغو'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = controller.text;
                if (title.isNotEmpty) {
                  final newRoutine = RoutineEntity(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: title,
                    days: List.filled(7, ''),
                    createdAt: DateTime.now(),
                  );
                  ref.read(routineNotifierProvider.notifier).addRoutine(newRoutine);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('افزودن'),
            ),
          ],
        );
      },
    );
  }
}
