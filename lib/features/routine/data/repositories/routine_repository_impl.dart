import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/features/routine/data/models/routine_table.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/routine_repository.dart';
import '../datasources/routine_local_data_source.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineLocalDataSource localDataSource;

  RoutineRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addRoutine(RoutineEntity routine) async {
    try {
      final routineCompanion = routine.toCompanion();

      await localDataSource.addRoutine(routineCompanion);

      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to add routine: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoutine(String id) async {
    try {
      await localDataSource.deleteRoutine(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete routine'));
    }
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines() async {
    try {
      final routineTbls = await localDataSource.getAllRoutines();
      
      final routines = routineTbls.map((tbl) => tbl.toEntity()).toList();
      
      return right(routines);
    } catch (e) {
      return left(DatabaseFailure('Failed to get routines: ${e.toString()}'));
    }
  }
}
