import 'package:sqflite/sqflite.dart';

import '../../core/strings/app_constraints.dart';
import '../../core/strings/database_values.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/counts/all_task_count_model.dart';
import '../models/task_model.dart';
import '../services/notifications/notification_service.dart';
import '../services/plado_database_service.dart';

class TaskDataRepository implements TaskRepository {
  final PladoDatabaseService _pladoDatabaseService;

  TaskDataRepository(this._pladoDatabaseService);

  final NotificationService _notificationService = NotificationService();

  @override
  Future<List<TaskEntity>> getTaskByCategoryId({required int categoryId, required String orderBy}) async {
    final String currentDateTime = DateTime.now().toIso8601String();
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskSampleBy} = ? AND ${DatabaseValues.dbTaskEndDateTime} >= ?', whereArgs: [categoryId, currentDateTime], orderBy: 'CASE WHEN ${DatabaseValues.dbTaskStatusIndex} = 1 THEN 1 ELSE 0 END, $orderBy');
    return resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
  }

  @override
  Future<List<TaskEntity>> getDailyTask({required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskSampleBy} = ?', whereArgs: [0], orderBy: 'CASE WHEN ${DatabaseValues.dbTaskStatusIndex} = 1 THEN 1 ELSE 0 END, $orderBy');
    return resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
  }

  @override
  Future<void> updateExpiredTasks() async {
    final String currentDateTime = DateTime.now().toIso8601String();
    final Database database = await _pladoDatabaseService.db;
    final Map<String, dynamic> taskCanceledMap = {
      DatabaseValues.dbTaskSampleBy: -1,
      DatabaseValues.dbTaskStatusIndex: 2,
      DatabaseValues.dbTaskCompleteDateTime: currentDateTime,
    };

    await database.transaction((txn) async {
      await txn.update(DatabaseValues.dbTaskTableName, taskCanceledMap,
        where: '${DatabaseValues.dbTaskSampleBy} != ? AND ${DatabaseValues.dbTaskSampleBy} != ? AND ${DatabaseValues.dbTaskEndDateTime} <= ? AND ${DatabaseValues.dbTaskStatusIndex} = ?',
        whereArgs: [-1, 0, currentDateTime, 0],
      );
    });
  }

  @override
  Future<void> updateCompletedTasks() async {
    final String currentDateTime = DateTime.now().toIso8601String();
    final Database database = await _pladoDatabaseService.db;
    final Map<String, dynamic> taskCompletedMap = {
      DatabaseValues.dbTaskSampleBy: -1,
    };

    await database.transaction((txn) async {
      await txn.update(DatabaseValues.dbTaskTableName, taskCompletedMap,
        where: '${DatabaseValues.dbTaskSampleBy} != ? AND ${DatabaseValues.dbTaskSampleBy} != ? AND ${DatabaseValues.dbTaskEndDateTime} <= ? AND ${DatabaseValues.dbTaskStatusIndex} = ?',
        whereArgs: [-1, 0, currentDateTime, 1],
      );
    });
  }

  @override
  Future<void> cancelNotificationsForCompletedTasks() async {
    final String currentDateTime = DateTime.now().toIso8601String();
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> canceledTasks = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskSampleBy} != ? AND ${DatabaseValues.dbTaskEndDateTime} <= ? AND ${DatabaseValues.dbTaskNotificationId} > ?',
      whereArgs: [0, currentDateTime, 0],
    );

    for (var task in canceledTasks) {
      final int notificationId = TaskModel.fromMap(task).notificationId;
      await _notificationService.cancelNotificationWithId(notificationId);
    }
  }

  @override
  Future<void> resetDailyTasks() async {
    final String currentDateTime = DateTime.now().toIso8601String();
    final Database database = await _pladoDatabaseService.db;
    await database.update(DatabaseValues.dbTaskTableName, {DatabaseValues.dbTaskStatusIndex: 0},
      where: '${DatabaseValues.dbTaskSampleBy} = ? AND ${DatabaseValues.dbTaskEndDateTime} <= ?',
      whereArgs: [0, currentDateTime],
    );
  }

  @override
  Future<TaskEntity> getTaskById({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId]);
    final TaskEntity? taskById = resources.isNotEmpty ? TaskEntity.fromModel(TaskModel.fromMap(resources.first)) : null;
    return taskById!;
  }

  @override
  Future<AllTaskCountModel> getAllTaskCount() async {
    final Database database = await _pladoDatabaseService.db;

    final List<Map<String, Object?>> all = await database.query(
      DatabaseValues.dbTaskTableName,
    );

    final List<Map<String, Object?>> inProgress = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ?',
      whereArgs: [0],
    );

    final List<Map<String, Object?>> complete = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ?',
      whereArgs: [1],
    );

    final List<Map<String, Object?>> canceled = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ?',
      whereArgs: [2],
    );

    return AllTaskCountModel(
      all: all.length,
      inProgress: inProgress.length,
      complete: complete.length,
      canceled: canceled.length,
    );
  }

  @override
  Future<int> getTaskCountByCategoryId({required int categoryId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> result = await database.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseValues.dbTaskTableName} WHERE ${DatabaseValues.dbTaskSampleBy} = ?',
      [categoryId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  Future<List<TaskEntity>> getTaskByStatus({required int taskStatusIndex}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = taskStatusIndex == 3 ? await database.query(DatabaseValues.dbTaskTableName, orderBy: '${DatabaseValues.dbTaskId} ${AppConstraints.descSort}') : await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskStatusIndex} = ?', whereArgs: [taskStatusIndex], orderBy: '${DatabaseValues.dbTaskId} ${AppConstraints.descSort}');
    final List<TaskEntity> taskByStatus = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return taskByStatus;
  }

  @override
  Future<int> createTask({required TaskModel taskModel}) async {
    final Database database = await _pladoDatabaseService.db;
    final int createTask = await database.insert(DatabaseValues.dbTaskTableName, taskModel.taskToMap());
    return createTask;
  }

  @override
  Future<int> updateTask({required Map<String ,dynamic> taskMap, required int taskId, }) async {
    final Database database = await _pladoDatabaseService.db;
    final int updateTask = await database.update(DatabaseValues.dbTaskTableName, taskMap, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.replace);
    return updateTask;
  }

  @override
  Future<int> deleteTask({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int deleteTask = await database.delete(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId]);
    return deleteTask;
  }
}
