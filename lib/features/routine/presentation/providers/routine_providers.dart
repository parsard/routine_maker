import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/core/di/database_provider.dart';
import 'package:routine_maker/core/usecase.dart';
import 'package:routine_maker/features/routine/data/datasources/routine_local_data_source.dart';
import 'package:routine_maker/features/routine/data/repositories/routine_repository_impl.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/domain/repositories/routine_repository.dart';
import 'package:routine_maker/features/routine/domain/usecases/add_routine_usecase.dart';
import 'package:routine_maker/features/routine/domain/usecases/delete_routine_usecase.dart';
import 'package:routine_maker/features/routine/domain/usecases/get_all_routine_usecase.dart';
import 'package:routine_maker/features/routine/domain/usecases/toggle_routine_day_usecase.dart';
import 'package:routine_maker/features/routine/domain/usecases/update_routine_usecase.dart'; // ⬅️ جدید
import 'package:routine_maker/features/routine/presentation/notifiers/routine_item_notifier.dart';
import 'package:routine_maker/features/routine/presentation/state/routine_state.dart';

final routineLocalDataSourceProvider = Provider<RoutineLocalDataSource>((ref) {
  return RoutineLocalDataSourceImpl(database: ref.watch(appDatabaseProvider));
});

final toggleRoutineDayUseCaseProvider = Provider<ToggleRoutineDayUseCase>((ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return ToggleRoutineDayUseCase(repository);
});

final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  final localDataSource = ref.watch(routineLocalDataSourceProvider);
  return RoutineRepositoryImpl(localDataSource: localDataSource);
});

final getAllRoutinesProvider = Provider<GetAllRoutinesUseCase>((ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return GetAllRoutinesUseCase(repository);
});

final addRoutineProvider = Provider<AddRoutineUseCase>((ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return AddRoutineUseCase(repository);
});

final deleteRoutineProvider = Provider<DeleteRoutineUseCase>((ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return DeleteRoutineUseCase(repository: repository);
});

final updateRoutineProvider = Provider<UpdateRoutineUseCase>((ref) {
  final repository = ref.watch(routineRepositoryProvider);
  return UpdateRoutineUseCase(repository: repository);
});

class RoutineNotifier extends StateNotifier<RoutineState> {
  RoutineNotifier(
    this._getAllRoutines,
    this._addRoutine,
    this._deleteRoutine,
    this._updateRoutine, 
  ) : super(const RoutineState()) {
    fetchAllRoutines();
  }

  final GetAllRoutinesUseCase _getAllRoutines;
  final AddRoutineUseCase _addRoutine;
  final DeleteRoutineUseCase _deleteRoutine;
  final UpdateRoutineUseCase _updateRoutine; 

  Future<void> fetchAllRoutines() async {
    state = state.copyWith(status: RoutineStatus.loading);
    final result = await _getAllRoutines(NoParams());
    result.fold(
      (failure) {
        state = state.copyWith(
            status: RoutineStatus.failure, errorMessage: failure.message);
      },
      (routines) {
        state =
            state.copyWith(status: RoutineStatus.success, routines: routines);
      },
    );
  }

  Future<void> addRoutine(RoutineEntity routine) async {
    final result = await _addRoutine(routine);
    result.fold(
      (failure) {},
      (success) {
        fetchAllRoutines();
      },
    );
  }

  Future<void> deleteRoutine(String id) async {
    final result = await _deleteRoutine(DeleteRoutineParams(id: id));
    result.fold(
      (failure) {},
      (success) {
        fetchAllRoutines();
      },
    );
  }

  Future<void> updateRoutine(RoutineEntity routine) async {
    final result = await _updateRoutine(routine);
    result.fold(
      (failure) {
      },
      (success) {
        fetchAllRoutines();
      },
    );
  }
}

final routineItemNotifierProvider = StateNotifierProvider.family<
    RoutineItemNotifier,
    RoutineItemState,
    RoutineEntity>(
  (ref, routine) {
    final toggleUseCase = ref.watch(toggleRoutineDayUseCaseProvider);
    return RoutineItemNotifier(
      toggleDayUseCase: toggleUseCase,
      routine: routine,
    );
  },
);

final routineNotifierProvider =
    StateNotifierProvider<RoutineNotifier, RoutineState>((ref) {
  final getAllRoutines = ref.watch(getAllRoutinesProvider);
  final addRoutine = ref.watch(addRoutineProvider);
  final deleteRoutine = ref.watch(deleteRoutineProvider);
  final updateRoutine = ref.watch(updateRoutineProvider); 
  return RoutineNotifier(
    getAllRoutines,
    addRoutine,
    deleteRoutine,
    updateRoutine, 
  );
});
