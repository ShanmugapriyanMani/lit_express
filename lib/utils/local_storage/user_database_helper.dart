import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class UserDatabaseHelper {
  static Database? _database;
  static const String _tableName = 'user_details';

  static const String _colUserId = 'user_id';
  static const String _colMemberId = 'member_id';
  static const String _colUserType = 'user_type';
  static const String _colFirstName = 'first_name';
  static const String _colLastName = 'last_name';
  static const String _colLibraryMemberCode = 'library_member_code';
  static const String _colAvatar = 'avatar';
  static const String _colPhone = 'phone';
  static const String _colToken = 'token';
  static const String _colTokenExpiry = 'token_expiry';

  UserDatabaseHelper._privateConstructor();

  static final UserDatabaseHelper instance = UserDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_colUserId TEXT PRIMARY KEY,
        $_colMemberId TEXT,
        $_colUserType TEXT,
        $_colFirstName TEXT,
        $_colLastName TEXT,
        $_colLibraryMemberCode TEXT,
        $_colAvatar TEXT,
        $_colPhone TEXT,
        $_colToken TEXT,
        $_colTokenExpiry TEXT
      )
    ''');
  }

  Future<void> insertUserData(Map<String, dynamic> userData) async {
    Database db = await instance.database;
    await db.insert(_tableName, userData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<void> clearUserData() async {
    Database db = await database;
    await db.delete(_tableName);
  }
  
}