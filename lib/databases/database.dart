import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:sembast_web/sembast_web.dart';

class TranslatorDB {
  TranslatorDB._internal();

  static TranslatorDB get instance => _singleton;

  static final TranslatorDB _singleton = TranslatorDB._internal();

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = kIsWeb? await initWebDb() : await initDB();
    return _db;
  }
  Future initWebDb() async {
    final database = await databaseFactoryWeb.openDatabase('history');
    return database;
  }

  Future initDB() async {
    final documentDIR = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDIR.path, 'history.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }



//   static openDb() async {
//     // File path to a file in the current directory
//     String dbPath = 'history.db';
//     DatabaseFactory dbFactory = databaseFactoryIo;
//
// // We use the database factory to open the database
//     Database db = await dbFactory.openDatabase(dbPath);
//   }
//
//   Future<Database> initDB() async {
//     // get the application documents directory
//     final dir = await getApplicationDocumentsDirectory();
//     // make sure it exists
//     //await dir.create(recursive: true);
//     // build the database path
//     final dbPath = join(dir.path, 'history.db');
//     // open the database
//     final db = await databaseFactoryIo.openDatabase(dbPath);
//   }
}