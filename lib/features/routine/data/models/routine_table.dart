// lib/features/routine/data/models/routine_table.dart
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide Table, Column;
import 'package:routine_maker/core/database/app_database.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';

@DataClassName('RoutineTbl')
class RoutineTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  DateTimeColumn get createdAt => dateTime()();

  IntColumn get alarmHour => integer().nullable()();
  IntColumn get alarmMinute => integer().nullable()();
  IntColumn get colorValue => integer().withDefault(const Constant(0xFF2196F3))();

  // ⬅️ ستون‌های جدید برای پیشرفت
  IntColumn get targetRepetitionsPerWeek => integer().withDefault(const Constant(1))();
  IntColumn get completedRepetitionsThisWeek => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

// ⬅️ Mapper: تبدیل از Table به Entity
extension RoutineTblMapper on RoutineTbl {
  RoutineEntity toEntity() {
    return RoutineEntity(
      id: id,
      title: title,
      createdAt: createdAt,
      alarmTime: (alarmHour != null && alarmMinute != null)
          ? TimeOfDay(hour: alarmHour!, minute: alarmMinute!)
          : null,
      color: Color(colorValue),
      targetRepetitionsPerWeek: targetRepetitionsPerWeek,
      completedRepetitionsThisWeek: completedRepetitionsThisWeek,
    );
  }
}

// ⬅️ Mapper: تبدیل از Entity به Companion
extension RoutineEntityMapper on RoutineEntity {
  RoutineTableCompanion toCompanion() {
    return RoutineTableCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      alarmHour: alarmTime != null ? Value(alarmTime!.hour) : const Value(null),
      alarmMinute: alarmTime != null ? Value(alarmTime!.minute) : const Value(null),
      colorValue: Value(color.value),
      targetRepetitionsPerWeek: Value(targetRepetitionsPerWeek),
      completedRepetitionsThisWeek: Value(completedRepetitionsThisWeek),
    );
  }
}
