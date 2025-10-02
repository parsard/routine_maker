import 'package:fpdart/fpdart.dart';
import 'package:routine_maker/core/error/failure.dart';
import 'package:routine_maker/core/usecase.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/domain/repositories/routine_repository.dart';

class UpdateRoutineUseCase implements UseCase<void, RoutineEntity> {
  final RoutineRepository repository;

  UpdateRoutineUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(RoutineEntity params) async {
    return await repository.updateRoutineProgress(params);
  }
}
