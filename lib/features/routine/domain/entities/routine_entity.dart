import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RoutineEntity extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<String> days;
  final TimeOfDay? alarmTime; 
  final Color color; 
  const RoutineEntity({required this.id, required this.title, required this.days, required this.createdAt,this.alarmTime,
    this.color = Colors.blue,});
  @override
  List<Object?> get props => [id, title, days, createdAt, alarmTime, color];
}
