// lib/core/database/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:routine_maker/features/routine/data/models/routine_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [RoutineTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5; 

@override
MigrationStrategy get migration {
  return MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      await m.deleteTable('routine_table');
      await m.createAll();
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        print('✅ Database created successfully');
      }
      if (details.hadUpgrade) {
        print('✅ Database upgraded successfully');
      }
    },
  );
}

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
