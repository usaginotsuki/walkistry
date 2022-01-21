import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider dbProvider = DBProvider._();
  DBProvider._();

  Future<Database> initDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'Walkistry.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Caminata(
            id INTEGER PRIMARY KEY,
          )''');
    });
  }
}
