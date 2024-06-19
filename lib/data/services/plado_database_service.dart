import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PladoDatabaseService {
  static final PladoDatabaseService _instance = PladoDatabaseService.internal();

  factory PladoDatabaseService() => _instance;

  PladoDatabaseService.internal();

  static Database? _db;
  static const int _dbVersion = 1;
  static const String _dbName = 'plado.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initializeDatabase();
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, _dbName);

    bool dbExists = await databaseExists(dbPath);
    Database database;

    if (!dbExists) {
      database = await openDatabase(dbPath, version: _dbVersion, onCreate: _createDb);
    } else {
      database = await openDatabase(dbPath);
      database.setVersion(_dbVersion);
    }

    return database;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE VIRTUAL TABLE IF NOT EXISTS Table_of_tasks USING FTS4 (
        task_id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_title TEXT,
        task_description TEXT,
        start_date_time TEXT,
        end_date_time TEXT,
        task_period TEXT,
        task_priority TEXT,
        task_status TEXT,
        task_color INTEGER,
        task_tags TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE Table_of_habits (
        habit_id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_title TEXT,
        habit_description TEXT,
        start_date_time TEXT,
        end_date_time TEXT,
        habit_period TEXT,
        completed_days TEXT
      );
    ''');
  }
}
