import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import '../models/models.dart';

class FilmDatabase {
  final String table = "films";
  final String primary = "id";

  late sql.Database _database;

  FilmDatabase() {
    _loadDatabase();
  }

  FutureOr<void> createTable(sql.Database database, int version) {
    database.execute(
      '''
          CREATE TABLE IF NOT EXIST $table
          (
            id integer primary key,
            title text not null,
            episode_id integer not null,
            opening_crawl text not null,
            director text not null,
            producer text not null,
            release_date text not null,
          )
        ''',
    );
  }

  FutureOr<void> dropTable(sql.Database database, int verison) {
    return database.execute(
      '''
        DROP TABLE IF EXIST $table;
      ''',
    );
  }

  Future<void> _loadDatabase() async {
    var databasePath = await sql.getDatabasesPath();
    String pathJoined = path.join(databasePath, "$table.db");
    _database = await sql.openDatabase(
      pathJoined,
      onCreate: createTable,
    );
  }

  Future<int> insert(Film movie) {
    return _database.insert(
      table,
      movie.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(int id) async {
    return await _database.delete(
      table,
      where: "$primary = ?",
      whereArgs: [id],
    );
  }

  Future<Film?> select(int id) async {
    List<Map> items = await _database.query(
      table,
      columns: ["*"],
      where: "$primary = ?",
      whereArgs: [id],
    );
    if (items.isNotEmpty) {
      return Film.fromMap(items.first as Map<String, dynamic>);
    }
  }

  Future<int> update(Film film) async {
    return await _database.update(table, film.toMap(),
        where: "$primary = ?",
        whereArgs: [film.id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future close() async => await _database.close();
}
