import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasbeeh_counter/Models/tasbeeh_data.dart';

const String tasbeehDB = 'tasbeeh.db';
const String tasbeehTable = 'tasbeehTable';

class TasbeehDatabase {
  static TasbeehDatabase instance = TasbeehDatabase._init();
  TasbeehDatabase._init();

  Database? _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await _getDatabase();
      return _database!;
    }
    return _database!;
  }

  Future _getDatabase() async {
    final dir = await getDatabasesPath();
    final path = join(dir, tasbeehDB);

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  void _createTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT';

    await db.execute('''
      CREATE TABLE $tasbeehTable(
        ${TasbeehFields.id} $idType,
        ${TasbeehFields.counterName} $textType,
        ${TasbeehFields.currentCount} $intType,
        ${TasbeehFields.totalCount} $intType,
        ${TasbeehFields.timeSnap} $textType
      )
  ''');
  }

  Future<Tasbeeh> createTasbeeh(Tasbeeh values) async {
    final db = await instance.database;

    final _id = await db.insert(tasbeehTable, values.toMap());

    return values.copyWith(id: _id);
  }

  Future<List<Tasbeeh>> readTasbeehat() async {
    final db = await instance.database;
    const _orderBy = '${TasbeehFields.timeSnap} DESC';
    final result = await db.query(tasbeehTable, orderBy: _orderBy);
    return result.map((value) => Tasbeeh.fromMap(value)).toList();
  }

  Future<Tasbeeh> readTasbeeh(int id) async {
    final db = await instance.database;
    final result = await db.query(tasbeehTable,
        columns: TasbeehFields.tasbeehList,
        where: '${TasbeehFields.id} = ?',
        whereArgs: [id]);

    if (result.isNotEmpty) {
      return Tasbeeh.fromMap(result.first);
    } else {
      throw Exception('ID $id not found in record');
    }
  }

  Future<int> updateTasbeeh(Tasbeeh value) async {
    final db = await instance.database;

    return await db.update(tasbeehTable, value.toMap(),
        where: '${TasbeehFields.id} = ?', whereArgs: [value.id]);
  }

  Future<int> deleteTasbeeh(int id) async {
    final db = await instance.database;
    return await db.delete(tasbeehTable,
        where: '${TasbeehFields.id} = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
