// lib/features/routine/data/models/routine_table.dart
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide Table, Column; 
import 'package:routine_maker/core/database/app_database.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';

@DataClassName('RoutineTbl')
class RoutineTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get days => text()(); 
  DateTimeColumn get createdAt => dateTime()(); 

  IntColumn get alarmHour => integer().nullable()();
  IntColumn get alarmMinute => integer().nullable()();
  IntColumn get colorValue => integer().withDefault(const Constant(0xFF2196F3))(); 


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
      alarmTime: (alarmHour != null && alarmMinute != null) 
? TimeOfDay(hour: alarmHour!, minute: alarmMinute!) 
: null,
color: Color(colorValue),
      
      
    );
  }
}

extension RoutineEntityMapper on RoutineEntity {
  RoutineTableCompanion toCompanion() {
    return RoutineTableCompanion(
      id: Value(id), 
      title: Value(title),
      days: Value(days.join(',')), 
      createdAt: Value(createdAt),
      alarmHour: alarmTime != null ? Value(alarmTime!.hour) : const Value(null),
alarmMinute: alarmTime != null ? Value(alarmTime!.minute) : const Value(null),
colorValue: Value(color.value),
    );
  }
}
