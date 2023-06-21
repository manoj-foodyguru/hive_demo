import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:isardb/models/address.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:isardb/models/user.dart';

class LocalDataAccess {

  init() async {
    if (kIsWeb) {
      Hive.init("./");
    } else {
      Directory appDocumentsDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentsDirectory.path);
    }

    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AddressAdapter());
  }

  // Opens a specific box
  openBox(box) async {
    return Hive.isBoxOpen(box) ? Hive.box(box) : Hive.openBox(box);
  }

  get<T>(int id, box) async {
    try {
      Box<dynamic> container = await openBox(box);
      return await container.get(id);
    } catch (e) {
      rethrow;
    }
  }

  getAll<T>(box) async {
    try {
      Box<dynamic> container = await openBox(box);
      return container.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  push<T>(T values, id, box) async {
    try {
      Box<dynamic> container = await openBox(box);
      container.put(id, values);
    } catch (e) {
      rethrow;
    }
  }

  delete<T>(id, box) async {
    try {
      Box<dynamic> container = await openBox(box);
      container.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  deleteAll<T>(box) async {
    try {
      Box<dynamic> container = await openBox(box);
      container.deleteAll(container.keys);
    } catch (e) {
      rethrow;
    }
  }
}
