import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'eventara.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT NOT NULL,
        eventId TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        UNIQUE(userId, eventId)
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_user_bookmarks ON bookmarks(userId, eventId)
    ''');
  }

  Future<int> addBookmark({
    required String userId,
    required String eventId,
  }) async {
    final db = await database;
    return await db.insert('bookmarks', {
      'userId': userId,
      'eventId': eventId,
      'createdAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeBookmark({
    required String userId,
    required String eventId,
  }) async {
    final db = await database;
    return await db.delete(
      'bookmarks',
      where: 'userId = ? AND eventId = ?',
      whereArgs: [userId, eventId],
    );
  }

  Future<List<String>> getUserBookmarkedEventIds(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'bookmarks',
      columns: ['eventId'],
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => map['eventId'] as String).toList();
  }

  Future<bool> isEventBookmarked({
    required String userId,
    required String eventId,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'bookmarks',
      where: 'userId = ? AND eventId = ?',
      whereArgs: [userId, eventId],
      limit: 1,
    );

    return maps.isNotEmpty;
  }

  Future<int> clearUserBookmarks(String userId) async {
    final db = await database;
    return await db.delete(
      'bookmarks',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<int> getBookmarkCount(String userId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM bookmarks WHERE userId = ?',
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
