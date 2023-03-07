import 'dart:async';
import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService implements StroageService {
  Box? box;

  final Completer<Box> initCompleter = Completer<Box>();

  @override
  void init() {
    initCompleter.complete(Hive.openBox('HiveService'));
  }

  @override
  bool get hasInitialized => initCompleter.isCompleted;

  @override
  Future<Object?> get(String key) async {
    box = await initCompleter.future;
    return box?.get(key);
  }

  @override
  Future<void> clear() async {
    box = await initCompleter.future;
    await box?.clear();
  }

  @override
  Future<bool> has(String key) async {
    box = await initCompleter.future;
    return box?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    box = await initCompleter.future;
    await box?.delete(key);
    return true;
  }

  @override
  Future<bool> set(String key, data) async {
    box = await initCompleter.future;
    await box?.put(key, data.toString());
    return true;
  }
}
