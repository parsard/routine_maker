

import 'package:routine_maker/core/database/app_database.dart'; 
abstract class RoutineLocalDataSource {
  Future<List<RoutineTbl>> getAllRoutines();
  Future<void> addRoutine(RoutineTbl routine);
}

class RoutineLocalDataSourceImpl implements RoutineLocalDataSource {
  final AppDatabase database;

  RoutineLocalDataSourceImpl({required this.database});

  @override
  Future<void> addRoutine(RoutineTbl routine) async {
    try {
      await database.into(database.routines).insert(routine);
    } catch (e) {
      throw Exception('Could not add routine to database');
    }
  }

  @override
  Future<List<RoutineTbl>> getAllRoutines() async {
    try {
      return await database.select(database.routines).get();
    } catch (e) {
      throw Exception('Could not retrieve routines from database');
    }
  }
}
