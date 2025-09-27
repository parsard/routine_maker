// lib/features/routine/data/models/routine_table.dart
import 'package:drift/drift.dart';
import 'package:routine_maker/core/database/app_database.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';


@DataClassName('RoutineTbl')
class RoutineTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get days => text()(); 
  DateTimeColumn get createdAt => dateTime()(); 

  @override
  Set<Column> get primaryKey => {id};
}



extension RoutineTblMapper on RoutineTbl {
  RoutineEntity toEntity() {
    return RoutineEntity(
      id: id, 
      title: title,
      days: days.split(',').where((day) => day.isNotEmpty).toList(),
      createdAt: createdAt,
      
      
    );
  }
}

extension RoutineEntityMapper on RoutineEntity {
  RoutineTableCompanion toCompanion() {
    return RoutineTableCompanion(
      id: Value(id), // Ensure id is a string for the database
      title: Value(title),
      days: Value(days.join(',')), // Placeholder for now
      createdAt: Value(createdAt), // Use the current date for now
    );
  }
}
