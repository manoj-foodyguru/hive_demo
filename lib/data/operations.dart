import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:hive/hive.dart';
import 'package:isardb/models/user.dart';

class Operations {
  static late BoxCollection db;
  static late Future<Box<dynamic>> box;

  registerAdapter() async {
    Hive.registerAdapter(UserAdapter());
  }

  openBox(box) async {
    return Hive.isBoxOpen(box) ? Hive.box(box) : Hive.openBox(box);
  }

  dbGet<T>(int id, box) async {
    try {
      Box<dynamic> container = await openBox(box);
      return await container.get(id);
    } catch (e) {
      rethrow;
    } finally {
      // Hive.close();
    }
  }

  dbGetAll<T>(box) async {
    try {
      Box<dynamic> container = await openBox(box);
      return container.values.toList();
    } catch (e) {
      rethrow;
    } finally {
      // Hive.close();
    }
  }

  dbPush<T>(T values, id, box) async {
    try {
      Box<dynamic> container = await openBox(box);
      container.put(id, values);
    } catch (e) {
      rethrow;
    } finally {
      // Hive.close();
    }
  }
}
