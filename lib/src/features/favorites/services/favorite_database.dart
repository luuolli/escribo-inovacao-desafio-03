import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:starwars/src/core/core.dart';

import '../models/models.dart';

class FavoriteDatabase {
  final String table = "favorites";
  final String primary = "id";

  late sql.Database _database;

  FutureOr<void> createTable(sql.Database database, int version) {
    database.execute(
      '''
          CREATE TABLE IF NOT EXISTS $table
          (
            id integer not null,
            type text not null,
            name text not null,
            PRIMARY KEY (id, type)
          )
      ''',
    );
  }

  FutureOr<void> dropTable(sql.Database database, int verison) {
    return database.execute(
      '''
        DROP TABLE IF EXISTS $table;
      ''',
    );
  }

  Future<void> open() async {
    var databasePath = await sql.getDatabasesPath();
    String pathJoined = path.join(databasePath, "$table.db");
    _database = await sql.openDatabase(
      pathJoined,
      onCreate: createTable,
      version: 1,
    );
  }

  Future<int> insert(Favorite favorite) {
    return _database.insert(
      table,
      favorite.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(int id, FavoriteType type) async {
    return await _database.delete(
      table,
      where: "$primary = ? AND type = ?",
      whereArgs: [id, type.toString().replaceAll('FavoriteType.', '')],
    );
  }

  Future<Favorite?> select(int id, FavoriteType type) async {
    List<Map> items = await _database.query(
      table,
      columns: ["*"],
      where: "$primary = ? AND type = ?",
      whereArgs: [id, type.toString().replaceAll('FavoriteType.', '')],
    );
    if (items.isNotEmpty) {
      return Favorite.fromMap(items.first as Map<String, dynamic>);
    }
  }

  Future<List<Favorite>?> selectAll() async {
    List<Map> items = await _database.query(
      table,
      columns: ["id", "name", "type"],
    );
    if (items.isNotEmpty) {
      return items.map((favorite) {
        return Favorite.fromMap(favorite as Map<String, dynamic>);
      }).toList();
    }
  }

  Future close() async => await _database.close();
}
