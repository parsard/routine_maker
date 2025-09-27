import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/core/usecase.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/domain/repositories/routine_repository.dart';

class AddRoutineUseCase implements UseCase<void, RoutineEntity> {
  final RoutineRepository repository;

  AddRoutineUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RoutineEntity params) async {
    return await repository.addRoutine(params);
  }
}
class AddRoutineParams {
  final RoutineEntity routine;

  AddRoutineParams({required this.routine});
}