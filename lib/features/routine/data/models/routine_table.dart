// lib/features/routine/data/models/routine_table.dart
import 'package:drift/drift.dart';
import 'package:routine_maker/core/database/app_database.dart';
import 'package:routine_maker/features/routine/domain/entities/routine.dart';


@DataClassName('RoutineTbl')
class RoutineTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get days => text()(); 
  DateTimeColumn get createdAt => dateTime()(); 

  @override
  Set<Column> get primaryKey => {id};
}



// This adds a new method `toEntity()` to the Drift-generated RoutineTbl class.
extension RoutineTblMapper on RoutineTbl {
  Routine toEntity() {
    return Routine(
      id: id, 
      title: title,
      days: days.split(',').where((day) => day.isNotEmpty).toList(),
      createdAt: createdAt,
      // The createdAt field is missing from our table. Let's add it!
      // For now, we'll use a placeholder.
       // We will fix this by adding the column to the table.
    );
  }
}

// This adds a new factory constructor `fromEntity` to the RoutineTbl class.
extension RoutineTblCompanionMapper on RoutineTbl {
  static RoutineTbl fromEntity(Routine entity) {
    return RoutineTbl(
      id: entity.id.toString(), // Ensure id is a string for the database
      title: entity.title,
      // We'll need a way to store the creation date.
      // And handle the 'days' logic.
      days: '', // Placeholder for now
      createdAt: DateTime.now(), // Use the current date for now
    );
  }
}
