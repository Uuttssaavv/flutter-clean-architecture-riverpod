import 'package:flutter_project/shared/data/local/shared_prefs_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final storageServiceProvider = Provider((ref) {
  Hive.initFlutter();
  return HiveService()..init();
});
