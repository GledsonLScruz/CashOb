import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Currency.dart';

class DatabaseHelper {
  static const DB_FILE_NAME = 'sqlite_crud.db';
  static const DB_CURRENT_VERSION = 1;

  static final DatabaseHelper _databaseHelper = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<Database?> get database async {
    Database database = await initializeDatabase();
    return database;
  }

  Future<Database> initializeDatabase() async {
    Directory applicationDocumentDirectory =
        await getApplicationDocumentsDirectory();

    String path = join(applicationDocumentDirectory.path, DB_FILE_NAME);

    var todosDatabase = await openDatabase(path,
        version: DB_CURRENT_VERSION, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${Currency.TABLE} ( '
        '${Currency.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${Currency.COL_NAME} TEXT, '
        '${Currency.COL_CODE} TEXT),'
        '${Currency.COL_VALUE} TEXT, '
        '${Currency.COL_IS_SELECTED} TEXT ');
  }
}
