import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/data/datasources/local/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
