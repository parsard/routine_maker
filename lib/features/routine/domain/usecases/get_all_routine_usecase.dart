import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/core/usecase.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/domain/repositories/routine_repository.dart';

class GetAllRoutinesUseCase implements UseCase<List<RoutineEntity>, NoParams> {
  final RoutineRepository repository;

  GetAllRoutinesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RoutineEntity>>> call(NoParams params) async  {
    return await repository.getAllRoutines();
  }
}