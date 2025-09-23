import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/features/routine/domain/entities/routine.dart';

abstract class RoutineRepository {
  Future<Either<Failure, List<Routine>>> getAllRoutines();
  Future<Either<Failure, void>> addRoutine(Routine routine);
}
