import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:studentdemoapp/model/UserModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;



  final String tableUser = 'userTable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnEmail = 'email';
  final String columnMobile = 'mobile';
  final String columnClass = 'class';
  final String columnBranch = 'branch';
  final String columnAddress = 'address';
  final String columnLat = 'lat';
  final String columnLang = 'lang';



  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }
/*

 initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
*/


  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'user.db');
    var ourDb = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return ourDb;
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      //db.execute("ALTER TABLE $tableUser ADD COLUMN $columnRssUniqueID TEXT");
    }
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnEmail TEXT, $columnMobile TEXT, $columnClass TEXT,$columnBranch TEXT, $columnAddress TEXT, $columnLat TEXT, $columnLang TEXT)');

  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableUser, user.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }


  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.query(tableUser, columns: [columnId, columnName, columnEmail,columnMobile,columnClass,columnBranch,columnAddress,columnLat,columnLang]);
    return result.toList();
  }


  Future<List> getUserWithEmailID(email) async {
    var dbClient = await db;
    //var result = await dbClient.query(tableUser, columns: [columnId, columnName, columnEmail,columnMobile,columnCountry,columnCity,columnOrganization,columnPassword]);

    String query = 'SELECT * FROM $tableUser WHERE $columnEmail = \'$email\'';
    var result = await dbClient.rawQuery(query);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableUser'));
  }

  Future<User> getUser(String email) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableUser,
      columns: [columnId, columnName, columnEmail,columnMobile,columnClass,columnBranch,columnAddress,columnLat,columnLang],
      where: '$columnEmail = ?',
      whereArgs: [email]);

//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new User.fromMap(result.first);
    }

    return null;
  }

  Future<List<User>>getUserList()async{
    var dbClient= await db;
    List<Map> result=await dbClient.query(tableUser,
      columns: [columnId,columnName,columnEmail,columnMobile,columnClass,columnBranch,columnAddress,columnLat,columnLang]);
    List<User> casesModelList=new List();
    if (result.length > 0) {
      for(int i=0;i<result.length;i++){
        casesModelList.add(User.fromMap(result[i]));
      }
      return casesModelList;
    }

    return null;
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(), where: "$columnId = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
