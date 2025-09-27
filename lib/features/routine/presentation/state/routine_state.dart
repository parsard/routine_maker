import 'package:equatable/equatable.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';

enum RoutineStatus { initial, loading, success, failure }

class RoutineState extends Equatable {
  const RoutineState({
    this.status = RoutineStatus.initial,
    this.routines = const <RoutineEntity>[],
    this.errorMessage = '',
  });

  final RoutineStatus status;
  final List<RoutineEntity> routines;
  final String errorMessage;

  RoutineState copyWith({
    RoutineStatus? status,
    List<RoutineEntity>? routines,
    String? errorMessage,
  }) {
    return RoutineState(
      status: status ?? this.status,
      routines: routines ?? this.routines,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, routines, errorMessage];
}
