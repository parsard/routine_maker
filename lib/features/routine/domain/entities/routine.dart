import 'package:equatable/equatable.dart';

class Routine extends Equatable {
  final String id;
  final String title;
  final List<String> days;
  const Routine({required this.id, required this.title, required this.days});
  @override
  List<Object?> get props => [id, title, days];
}
