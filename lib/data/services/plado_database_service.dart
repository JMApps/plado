import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/strings/app_constraints.dart';
import '../../core/strings/database_values.dart';

class PladoDatabaseService {
  static final PladoDatabaseService _instance = PladoDatabaseService.internal();

  factory PladoDatabaseService() => _instance;

  PladoDatabaseService.internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initializeDatabase();
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, AppConstraints.dbName);

    bool dbExists = await databaseExists(dbPath);
    Database database;

    if (!dbExists) {
      database = await openDatabase(dbPath, version: AppConstraints.dbVersion, onCreate: _createDb);
    } else {
      database = await openDatabase(dbPath);
      database.setVersion(AppConstraints.dbVersion);
    }

    return database;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseValues.dbTaskTableName} (
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
      CREATE TABLE ${DatabaseValues.dbHabitTableName} (
        ${DatabaseValues.dbHabitId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseValues.dbHabitTitle} TEXT,
        ${DatabaseValues.dbHabitCreateDateTime} TEXT,
        ${DatabaseValues.dbHabitCompleteDateTime} TEXT,
        ${DatabaseValues.dbHabitStartDateTime} TEXT,
        ${DatabaseValues.dbHabitEndDateTime} TEXT,
        ${DatabaseValues.dbHabitPeriodIndex} INTEGER,
        ${DatabaseValues.dbHabitColorIndex} INTEGER,
        ${DatabaseValues.dbHabitCompletedDays} TEXT,
        ${DatabaseValues.dbHabitNotificationId} INTEGER,
        ${DatabaseValues.dbHabitNotificationDate} TEXT
        );
    ''');
  }
}
