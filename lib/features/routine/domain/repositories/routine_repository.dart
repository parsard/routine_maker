import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';

abstract class RoutineRepository {
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines();
  Future<Either<Failure, void>> addRoutine(RoutineEntity routine);
  Future<Either<Failure, void>> deleteRoutine(String id);
}
