
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService{

  LocalDatabaseService._privateConstructor();
  static final LocalDatabaseService instance = LocalDatabaseService._privateConstructor();

  static final _dbname = 'recipes1.db';
  static final _dbversion = 1;
  static final _tableName = 'Recipes1';
  static final columnID='_id';
  static final uid = '_uid';
  static final authorName = '_authorName';
  static final recipeCount = '_recipeCount';
  static final recipeName = '_recipeName';
  static final recipePrepTime = '_recipePrepTime';
  static final cookingTime = '_cookingTime';
  static final ingredients = '_ingredients';
  static final quantity = '_quantity';
  static final units = '_units';
  static final steps = '_steps';
  static final private = '_private';

  static Database _database;
  Future<Database> get database async{
    if (_database!=null){
    return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase () async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbname);
    return await openDatabase(path,version:_dbversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version){
    db.execute(
      '''
      CREATE TABLE $_tableName( $columnID INTEGER PRIMARY KEY,
      $uid TEXT,
      $authorName TEXT NOT NULL,
      $recipeCount INTEGER,
      $recipeName TEXT,
      $cookingTime INTEGER,
      $recipePrepTime INTEGER,
      $steps TEXT,
      $ingredients TEXT,
      $quantity TEXT,
      $units TEXT,
      $private TEXT
      ) 

      '''
    );
  }


  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }


  Future<List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future update(Map<String,dynamic> row, String name) async{
    Database db = await instance.database;
    return await db.update(_tableName, row, where: '$recipeName = ?', whereArgs:[name] );
  }

  Future<int> delete1(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnID = ?', whereArgs: [id]);
  }

}