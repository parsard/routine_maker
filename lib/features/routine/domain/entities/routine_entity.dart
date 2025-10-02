import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RoutineEntity extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final TimeOfDay? alarmTime;
  final Color color;
  
  final int targetRepetitionsPerWeek;  // ⬅️ تعداد روزهای هدف
  final int completedRepetitionsThisWeek; 

  const RoutineEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    this.alarmTime,
    this.color = Colors.blue,
    this.targetRepetitionsPerWeek = 1, 
    this.completedRepetitionsThisWeek = 0, 
  });

  double get progressPercentage {
    if (targetRepetitionsPerWeek == 0) return 0.0;
    final progress = completedRepetitionsThisWeek / targetRepetitionsPerWeek;
    return progress.clamp(0.0, 1.0); 
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        alarmTime,
        color,
        targetRepetitionsPerWeek,
        completedRepetitionsThisWeek,
      ];

  RoutineEntity copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    TimeOfDay? alarmTime,
    Color? color,
    int? targetRepetitionsPerWeek,
    int? completedRepetitionsThisWeek,
  }) {
    return RoutineEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      alarmTime: alarmTime ?? this.alarmTime,
      color: color ?? this.color,
      targetRepetitionsPerWeek: targetRepetitionsPerWeek ?? this.targetRepetitionsPerWeek,
      completedRepetitionsThisWeek: completedRepetitionsThisWeek ?? this.completedRepetitionsThisWeek,
    );
  }
}
