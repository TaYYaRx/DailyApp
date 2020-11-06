import 'dart:io';
import 'dart:async';

import 'package:daily/models/category_model.dart';
import 'package:daily/models/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  static String table1 = 'kategoriler';
  static String table2 = 'todos';

  DatabaseHelper.init();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.init();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  _getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'datasem.db');
    return openDatabase(path,
        version: 1, onCreate: _oncreate, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _oncreate(Database db, int version) async {
    String table1 =
        'CREATE TABLE kategoriler (id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT NOT NULL)';
    String table2 =
        'CREATE TABLE todos (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT,' +
            'content TEXT, isDone INTEGER, kategoriID INTEGER NOT NULL, FOREIGN KEY (kategoriID) REFERENCES kategoriler (id) ON DELETE CASCADE ON UPDATE CASCADE)';
    await db.execute(table1);
    await db.execute(table2);
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    Database db = await _getDatabase();
    return db.query(table1);
  }

  Future<List<Map<String, dynamic>>> getAllTodos() async {
    Database db = await _getDatabase();
    return db.query(table2);
  }

  Future<int> addCategoryToSQL(CategoryModel model) async {
    Database db = await _getDatabase();
    return db.insert(table1, model.toMap());
  }

  Future<int> addTodoToSQL(TodoModel model) async {
    Database db = await _getDatabase();
    return db.insert(table2, model.toMap());
  }

  Future<int> deleteCategory(CategoryModel model) async {
    Database db = await _getDatabase();
    return db.delete(table1, where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> deleteTodo(TodoModel model) async {
    Database db = await _getDatabase();
    return db.delete(table2, where: 'id = ?', whereArgs: [model.getTodoId]);
  }

  Future<int> updateCategory(CategoryModel model) async {
    Database db = await _getDatabase();
    return await db.update(table1, model.toMap(),
        where: 'id = ?', whereArgs: [model.getId]);
  }

  Future<int> updateTodo(TodoModel model) async {
    Database db = await _getDatabase();
    return await db.update(table2, model.toMap(),
        where: 'id = ?', whereArgs: [model.getTodoId]);
  }

  
}

/**
 *static DatabaseHelper _databaseHelper;
  static Database _database;
  static const String TABLE_NAME = 'kategoriler';
  static const String TABLE_NAME2 = 'todos';

  DatabaseHelper.internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }
  _getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();

      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initDatabase() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasePath = await getDatabasesPath();
          var path = join(databasePath, "mytodoliste.db");
          var file = new File(path);

          //check if file exists
          if (!await file.exists()) {
            //copy from assets
            ByteData data =
                await rootBundle.load(join("assets", "mytodolist.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          //open databse
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }

  //------KategoriTable
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    Database db = await _getDatabase();
    return await db.query(TABLE_NAME);
  }

  Future<int> addCategoryToSQL(CategoryModel kategori) async {
    Database db = await _getDatabase();
    return await db.insert(TABLE_NAME, kategori.toMap());
  }

  Future<int> deleteCategory(CategoryModel model) async {
    Database db = await _getDatabase();
    var inta =
        await db.delete(TABLE_NAME, where: 'id = ?', whereArgs: [model.getId]);
    print(inta);
    return inta;
  }

  Future<int> updateCategory(CategoryModel model) async {
    Database db = await _getDatabase();
    return await db.update(TABLE_NAME, model.toMap(),
        where: 'id = ?', whereArgs: [model.getId]);
  }

  //-------todosTable
  Future<List<Map<String, dynamic>>> getAllTodos() async {
    Database db = await _getDatabase();
    return await db.query(TABLE_NAME2);
  }

  Future<int> addTodoToSQL(TodoModel model) async {
    Database db = await _getDatabase();
    return await db.insert(TABLE_NAME2, model.toMap());
  }

  Future<int> deleteTodo(TodoModel model) async {
    Database db = await _getDatabase();
    return await db
        .delete(TABLE_NAME2, where: 'id = ?', whereArgs: [model.getTodoId]);
  }

  Future<int> updateTodo(TodoModel model) async {
    Database db = await _getDatabase();
    return await db.update(TABLE_NAME2, model.toMap(),
        where: 'id = ?', whereArgs: [model.getTodoId]);
  }


 * 
 * 
 * 
 */
