// // ignore_for_file: unnecessary_this

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class StarWarsDatabase {
//   static Future<Database> db(String databaseName) async {
//     var databasePath = await getDatabasesPath();
//     String path = join(databasePath, "$databaseName.db");
//     var database = await openDatabase(
//       path, version: 1,
//       // onCreate: (Database db, int verision) {
//       //   db.execute('CREATE TABLE');
//       // },
//     );

//     return database;
//   }
// }

// class FavoriteTable {
//   final String table = 'favorite';

//   final Database db;

//   const FavoriteTable({required this.db});

//   // insert
//   void insert(Favorite favorite) {
//     db.rawInsert(db.insert(table, );
//   }

//   // update
//   // delete
//   // select
// }
