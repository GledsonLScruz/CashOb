import 'package:sqflite/sqflite.dart';

import '../model/Currency.dart';
import 'database_helper.dart';

class CurrencyHelper {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> insert(Currency currency) async {
    final db = await databaseHelper.database;
    await db?.insert(Currency.TABLE, currency.toMap());
  }

  Future<List<Currency>> list() async {
    final db = await databaseHelper.database;
    var objects = await db!.rawQuery('SELECT * FROM ${Currency.TABLE} '
        'ORDER BY ${Currency.COL_NAME} COLLATE NOCASE');

    return objects.map((obj) => Currency.fromMap(obj)).toList();
  }

  Future<void> update(Currency todo) async {
    final db = await databaseHelper.database;
    await db!.update(Currency.TABLE, todo.toMap(),
        where: '${Currency.COL_ID} = ?', whereArgs: [todo.id]);
  }

  Future<void> delete(int id) async {
    var db = await databaseHelper.database;
    db!.delete(
      Currency.TABLE,
      where: "${Currency.COL_ID} = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    var db = await databaseHelper.database;
    db!.delete(Currency.TABLE);
  }
}
