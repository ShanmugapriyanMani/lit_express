import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class CheckOutListHelper {
  static Database? _database;
  static const String _tableName = 'books';

  static const String _collBookId = 'bookId';
  static const String _colAuthorId = 'authorId';
  static const String _colCategoryId = 'categoryId';
  static const String _colPublisherId = 'publisherId';
  static const String _colBookName = 'bookName';
  static const String _colDescription = 'description';
  static const String _colCoverImage = 'coverImage';
  static const String _colLibraryBookCode = 'libraryBookCode';
  static const String _colIsbn = 'isbn';
    static const String _colCreatedDate = 'createdDate';
  static const String _colCategoryName = 'categoryName';
  static const String _colAuthorName = 'authorName';
  static const String _colLanguageName = 'languageName';
  static const String _colPublisherName = 'publisherName';
  static const String _colStockAvailable = 'stockAvailable';

  CheckOutListHelper._privateConstructor();

  static final CheckOutListHelper instance = CheckOutListHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'books_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_collBookId TEXT PRIMARY KEY,
        $_colAuthorId TEXT,
        $_colCategoryId TEXT,
        $_colPublisherId TEXT,
        $_colBookName TEXT,
        $_colDescription TEXT,
        $_colCoverImage TEXT,
        $_colLibraryBookCode TEXT,
        $_colIsbn TEXT,
        $_colCreatedDate TEXT,
        $_colCategoryName TEXT,
        $_colAuthorName TEXT,
        $_colLanguageName TEXT,
        $_colPublisherName TEXT,
        $_colStockAvailable TEXT
      )
    ''');
  }

  Future<void> insertBookData(Map<String, dynamic> userData) async {
    Database db = await instance.database;
    await db.insert(_tableName, userData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>?>> getBookListData() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
    );

    return result.isNotEmpty ? result : [];
  }

  Future<void> deleteBookById(String bookId) async {
    Database db = await database;
    await db.delete(
      _tableName,
      where: '$_collBookId = ?',
      whereArgs: [bookId],
    );
  }

  Future<void> clearUserData() async {
    Database db = await database;
    await db.delete(_tableName);
  }

}