import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';

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
      CREATE TABLE Table_of_tasks (
        ${DatabaseValues.dbTaskId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseValues.dbTaskTitle} TEXT,
        ${DatabaseValues.dbTaskCreateDateTime} TEXT,
        ${DatabaseValues.dbTaskCompleteDateTime} TEXT,
        ${DatabaseValues.dbTaskStartDateTime} TEXT,
        ${DatabaseValues.dbTaskEndDateTime} TEXT,
        ${DatabaseValues.dbTaskPeriodIndex} INTEGER,
        ${DatabaseValues.dbTaskPriorityIndex} INTEGER,
        ${DatabaseValues.dbTaskStatusIndex} INTEGER,
        ${DatabaseValues.dbTaskColorIndex} INTEGER,
        ${DatabaseValues.dbTaskNotificationId} INTEGER,
        ${DatabaseValues.dbTaskNotificationDate} TEXT
        );
    ''');

    await db.execute('''
      CREATE TABLE Table_of_habits (
        habit_id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_title TEXT,
        create_date_time TEXT,
        complete_date_time TEXT,
        start_date_time TEXT,
        end_date_time TEXT,
        habit_period_index INTEGER,
        habit_color_index INTEGER,
        completed_days TEXT,
        notification_id INTEGER,
        notification_date TEXT
        );
    ''');
  }
}
