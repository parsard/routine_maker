import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_maker/core/database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
