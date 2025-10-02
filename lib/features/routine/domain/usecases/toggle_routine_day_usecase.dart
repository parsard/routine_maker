// lib/features/routine/domain/usecases/toggle_routine_day_usecase.dart
import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/domain/repositories/routine_repository.dart';
import 'package:routine_maker/features/routine/domain/usecases/update_routine_usecase.dart';

class ToggleRoutineDayUseCase {
  final RoutineRepository repository;

  ToggleRoutineDayUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required RoutineEntity routine,
    required int dayIndex,
    required bool currentStatus,
  }) async {
    final newCompletedCount = currentStatus
        ? routine.completedRepetitionsThisWeek - 1
        : routine.completedRepetitionsThisWeek + 1;

    final validatedCount = newCompletedCount.clamp(
      0,
      routine.targetRepetitionsPerWeek,
    );

    final updatedRoutine = routine.copyWith(
      completedRepetitionsThisWeek: validatedCount,
    );

    return await repository.updateRoutineProgress(updatedRoutine);
  }
}
