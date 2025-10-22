import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ThemeLocalDB {
  static final ThemeLocalDB _instance = ThemeLocalDB._internal();
  factory ThemeLocalDB() => _instance;
  ThemeLocalDB._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'theme_settings.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE theme(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            is_dark INTEGER
          )
        ''');
        // Default: Light Mode
        await db.insert('theme', {'is_dark': 0});
      },
    );
  }

  Future<bool> getTheme() async {
    final db = await database;
    final result = await db.query('theme', limit: 1);
    if (result.isNotEmpty) {
      return result.first['is_dark'] == 1;
    }
    return false; // default light mode
  }

  Future<void> setTheme(bool isDark) async {
    final db = await database;
    await db.update('theme', {'is_dark': isDark ? 1 : 0});
  }
}
