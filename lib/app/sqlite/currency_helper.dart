import 'package:sqflite/sqflite.dart';

import '../model/Currency.dart';
import 'database_helper.dart';

class CurrencyHelper {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Currency>> list(String selectedCurrency) async {
    final db = await databaseHelper.database;
    var objects = await db!.rawQuery('SELECT * FROM ${Currency.TABLE} '
        'WHERE ${Currency.COL_REF_CODE}=$selectedCurrency '
        'ORDER BY ${Currency.COL_NAME} COLLATE NOCASE');
    return objects.map((obj) => Currency.fromMap(obj)).toList();
  }

  Future<void> insertList(List<Currency> listOfCurrencys) async {
    final db = await databaseHelper.database;
    for (var currency in listOfCurrencys) {
      await db?.insert(Currency.TABLE, currency.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> updateList(List<Currency> listOfCurrencys) async {
    final db = await databaseHelper.database;
    for (var currency in listOfCurrencys) {
      await db!.update(Currency.TABLE, currency.toMap(),
          where: '${Currency.COL_CODE} = ?',
          whereArgs: [currency.code],
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> delete(int id) async {
    var db = await databaseHelper.database;
    db!.delete(
      Currency.TABLE,
      where: "${Currency.COL_CODE} = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    var db = await databaseHelper.database;
    db!.delete(Currency.TABLE);
  }
}
