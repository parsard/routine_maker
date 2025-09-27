import 'package:equatable/equatable.dart';

class RoutineEntity extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<String> days;
  const RoutineEntity({required this.id, required this.title, required this.days, required this.createdAt});
  @override
  List<Object?> get props => [id, title, days];
}
