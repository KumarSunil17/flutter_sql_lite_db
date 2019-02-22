import 'dart:io';
import 'package:flutter_sql_lite_db/pojos/people_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{

  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "PeopleDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE People ("
          "name TEXT,"
          "gender TEXT,"
          "phone TEXT,"
          "email TEXT,"
          "age TEXT"
          ")");
    });
  }

  newPeople(People newClient) async {
    final db = await database;
    var res;
    await db.rawInsert(
        "INSERT INTO People(name,gender,phone,email,age)"
            " VALUES (?,?,?,?,?)", [newClient.name, newClient.gender, newClient.phone, newClient.email, newClient.age])
        .whenComplete((){
      return res;
    });
  }

  Future<List<People>> getAllPeople() async {
    final db = await database;
    var res = await db.query("People").whenComplete((){
      print("Completeed featching!");
    });

      List<People> list = res.isNotEmpty ? res.map((c) => People.fromMap(c)).toList() : [];
    return list;
  }

  updatePeople(People newClient) async {
    final db = await database;
    var res = await db.update("People", newClient.toMap(),
        where: "email = ?", whereArgs: [newClient.email]);
    return res;
  }

  deletePeople(String email) async {
    final db = await database;
    return db.delete("People", where: "email = ?", whereArgs: [email]);
  }

  deleteAll() async {
    final db = await database;
    return db.rawDelete("Delete * from People");
  }
}