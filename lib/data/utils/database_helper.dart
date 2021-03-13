import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static DatabaseHelper _instance = DatabaseHelper._internal();
  Future<Database> _database;
  DatabaseHelper._internal(){
    WidgetsFlutterBinding.ensureInitialized();

  }

  Future<Database> getDatabase() async{
    if(_database == null){
      _database =  openDatabase(
          join(await getDatabasesPath(), 'cart_upon_database.db'),
        onCreate: (db, version){
            return db.execute('CREATE TABLE cart_items(id INTEGER PRIMARY KEY, name TEXT, type TEXT, price TEXT, image TEXT, shortDescription TEXT, fullDescription TEXT, quantity INTEGER)');
        },
        version: 1
      );
    }
    return _database;
  }

  factory DatabaseHelper() => _instance;

}