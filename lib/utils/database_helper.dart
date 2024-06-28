import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  Database? database;

  Future<Database?> checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await initDb();
    }
  }

  Future<Future<Database>> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "note.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT,color INTEGER)";
        db.execute(query);
      },
    );
  }

  Future<void> insertNotes({title, note, color}) async {
    database = await checkDb();
    database!.insert("notes", {"title": title, "note": note, "color": color});
  }

  Future<List<Map>> readNotes() async {
    database = await checkDb();
    String query = "SELECT * FROM notes";
    List<Map> list = await database!.rawQuery(query);
    print(list);
    return list;
  }

  Future<void> updateNotes(id, title, note, color) async {
    database = await checkDb();
    database!.update("notes", {"title": title, "note": note, "color": color},
        where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteNotes(id) async {
    database = await checkDb();
    database!.delete("notes", where: "id=?", whereArgs: [id]);
  }
}
