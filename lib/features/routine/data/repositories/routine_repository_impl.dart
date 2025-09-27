
import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/database/app_database.dart';
import 'package:routine_maker/features/routine/data/models/routine_table.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/routine_repository.dart';
import '../datasources/routine_local_data_source.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineLocalDataSource localDataSource;

  // It depends on the low-level data source.
  RoutineRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addRoutine(RoutineEntity routine) async {
    try {
      // 1. Map the Domain Entity (`Routine`) to a Data Model (`RoutineTbl`).
      final routineCompanion = routine.toCompanion();

      // 2. Call the data source method.
      await localDataSource.addRoutine(routineCompanion);

      // 3. Return Right with void (represented by unit).
      return right(unit);
    } catch (e) {
      // 4. If anything goes wrong, catch it and return a Failure.
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
      // 1. Call the data source to get the list of data models.
      final routineTbls = await localDataSource.getAllRoutines();
      
      // 2. Map the list of Data Models (`RoutineTbl`) to a list of Domain Entities (`Routine`).
      final routines = routineTbls.map((tbl) => tbl.toEntity()).toList();
      
      // 3. Return the successful result.
      return right(routines);
    } catch (e) {
      // 4. If anything goes wrong, catch it and return a Failure.
      return left(DatabaseFailure('Failed to get routines: ${e.toString()}'));
    }
  }
}
