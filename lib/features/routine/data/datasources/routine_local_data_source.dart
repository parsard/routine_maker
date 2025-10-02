

import 'package:routine_maker/core/database/app_database.dart'; 
abstract class RoutineLocalDataSource {
  Future<List<RoutineTbl>> getAllRoutines();
  Future<void> addRoutine(RoutineTableCompanion routineCompanion);
  Future<void> deleteRoutine(String id);
  Future<void> updateRoutine(RoutineTableCompanion routine);
}

class RoutineLocalDataSourceImpl implements RoutineLocalDataSource {
  final AppDatabase database;

  RoutineLocalDataSourceImpl({required this.database});

  @override
  Future<void> updateRoutine(RoutineTableCompanion routine) async {
    await database.update(database.routineTable).replace(routine);
  }

  @override
  Future<void> addRoutine(RoutineTableCompanion routineCompanion) async {
    try {
      await database.into(database.routineTable).insert(routineCompanion);
    } catch (e) {
      throw Exception('Could not add routine to database');
    }
  }

  @override
  Future<void> deleteRoutine(String id) async {
    try {
      await (database.delete(database.routineTable)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (e) {
      throw Exception('Could not delete routine from database');
    }
  }

  @override
  Future<List<RoutineTbl>> getAllRoutines() async {
    try {
      return await database.select(database.routineTable).get();
    } catch (e) {
      throw Exception('Could not retrieve routines from database');
    }
  }
}
