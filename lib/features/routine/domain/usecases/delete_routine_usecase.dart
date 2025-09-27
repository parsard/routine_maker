// lib/features/routine/domain/usecases/delete_routine.dart

import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/features/routine/domain/repositories/routine_repository.dart';

class DeleteRoutineUseCase { 
  final RoutineRepository repository;

  DeleteRoutineUseCase({required this.repository}); 

  Future<Either<Failure, void>> call(DeleteRoutineParams params) async {
    return await repository.deleteRoutine(params.id);
  }
}

class DeleteRoutineParams {
  final String id;

  DeleteRoutineParams({required this.id});
}
