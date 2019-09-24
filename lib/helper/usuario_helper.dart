import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String userTable = "userTable";
final String idColumn = "id";
final String emailColumn = "email";
final String passwordColumn = "password";

class UserHelper {
  static final UserHelper _instance = UserHelper.internal();
  factory UserHelper() => _instance;
  UserHelper.internal();
  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "person.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $userTable($idColumn INTEGER PRIMARY KEY, $emailColumn TEXT, $passwordColumn TEXT)"
      );
    });
  }

  Future<User> savePerson(User user) async {
    Database dbPerson = await db;
    user.id = await dbPerson.insert(userTable, user.toMap());
    return user;
  }

  Future<User> getPerson(int id) async {
    Database dbPerson = await db;
    List<Map> maps = await dbPerson.query(userTable,
        columns: [idColumn, emailColumn, passwordColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletePerson(int id) async {
    Database dbPerson = await db;
    return await dbPerson.delete(userTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updatePerson(User user) async {
    Database dbPerson = await db;
    return await dbPerson.update(userTable,
        user.toMap(),
        where: "$idColumn = ?",
        whereArgs: [user.id]);
  }

  Future<List> getAllPersons() async {
    Database dbPerson = await db;
    List listMap = await dbPerson.rawQuery("SELECT * FROM $userTable");
    List<User> listUser = List();
    for(Map m in listMap){
      listUser.add(User.fromMap(m));
    }
    return listUser;
  }

  Future close() async {
    Database dbPerson = await db;
    dbPerson.close();
  }

}

class User {

  int id;
  String email;
  String password;

  User();

  User.fromMap(Map map){
    id = map[idColumn];
    email = map[emailColumn];
    password = map[passwordColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      emailColumn: email,
      passwordColumn: password
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "User(id: $id, email: $email, senha: $password)";
  }

}