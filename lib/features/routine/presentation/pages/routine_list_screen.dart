// lib/features/routine/presentation/screens/routine_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/presentation/providers/routine_providers.dart'; // فایل Provider های شما
import 'package:routine_maker/features/routine/presentation/state/routine_state.dart';
import 'package:routine_maker/features/routine/presentation/widgets/app_header.dart';
import 'package:routine_maker/features/routine/presentation/widgets/routine_list_item.dart';
import 'package:routine_maker/features/routine/presentation/widgets/weekly_calender.dart';

// lib/features/routine/presentation/screens/routine_list_screen.dart

// ... ایمپورت‌های قبلی ...
import 'package:routine_maker/features/routine/presentation/widgets/add_routine_bottom_sheet.dart'; // ایمپورت جدید

class RoutineListScreen extends ConsumerWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(routineNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onAddPressed: () {
                // تابع دیالوگ را با تابع BottomSheet جایگزین می‌کنیم
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
    // ... این تابع بدون تغییر باقی می‌ماند ...
    // فقط در RoutineListItem باید رنگ را هم پاس بدهید
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
              // color: routine.color,
              onDelete: () {
                ref.read(routineNotifierProvider.notifier).deleteRoutine(routine.id);
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

  // تابع جدید برای نمایش BottomSheet
  void _showAddRoutineBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // این دو خط باعث می‌شود BottomSheet بالای کیبورد قرار بگیرد
      isScrollControlled: true,
      // شکل گوشه‌های بالا را گرد می‌کند
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const AddRoutineBottomSheet();
      },
    );
  }

  // این تابع دیگر لازم نیست، می‌توانید آن را حذف کنید.
  /*
  void _showAddRoutineDialog(BuildContext context, WidgetRef ref) {
    // ...
  }
  */
}
