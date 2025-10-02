// lib/features/routine/presentation/notifiers/routine_item_notifier.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/domain/usecases/toggle_routine_day_usecase.dart';

class RoutineItemState {
  final List<bool> doneStatus;
  final bool isLoading;
  final String? errorMessage;

  const RoutineItemState({
    required this.doneStatus,
    this.isLoading = false,
    this.errorMessage,
  });
}

class RoutineItemNotifier extends StateNotifier<RoutineItemState> {
  final ToggleRoutineDayUseCase toggleDayUseCase;
  final RoutineEntity routine;

  RoutineItemNotifier({
    required this.toggleDayUseCase,
    required this.routine,
  }) : super(
          RoutineItemState(
            doneStatus: List.generate(
              7,
              (index) => index < routine.completedRepetitionsThisWeek,
            ),
          ),
        );

  Future<void> toggleDay(int index) async {
    final currentStatus = state.doneStatus[index];
    final previousDoneStatus = List<bool>.from(state.doneStatus);
    
    final newDoneStatus = List<bool>.from(state.doneStatus);
    newDoneStatus[index] = !currentStatus;
    
    // ⬅️ ساخت مستقیم state جدید
    state = RoutineItemState(
      doneStatus: newDoneStatus,
      isLoading: true,
      errorMessage: null,
    );

    final result = await toggleDayUseCase(
      routine: routine,
      dayIndex: index,
      currentStatus: currentStatus,
    );

    result.fold(
      (failure) {
        state = RoutineItemState(
          doneStatus: previousDoneStatus,
          isLoading: false,
          errorMessage: 'خطا در به‌روزرسانی',
        );
      },
      (_) {
        // Use the already computed local newDoneStatus on success (use case returns void)
        state = RoutineItemState(
          doneStatus: newDoneStatus,
          isLoading: false,
          errorMessage: null,
        );
      },
    );
  }

  void updateFromRoutine(RoutineEntity newRoutine) {
    final updatedDoneStatus = List.generate(
      7,
      (i) => i < newRoutine.completedRepetitionsThisWeek,
    );
    
    state = RoutineItemState(
      doneStatus: updatedDoneStatus,
      isLoading: state.isLoading,
      errorMessage: null,
    );
  }

  Color getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.lightGreen;
    if (progress >= 0.4) return Colors.orange;
    return Colors.red;
  }
}
