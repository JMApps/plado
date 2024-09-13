import 'package:sqflite/sqflite.dart';

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

  @override
  Future<List<TaskEntity>> getTaskByCategoryId({required int categoryId, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final currentDateTime = DateTime.now().toIso8601String();

    final Map<String, dynamic> taskCanceledMap = {
      DatabaseValues.dbTaskSampleBy: -1,
      DatabaseValues.dbTaskStatusIndex: 2,
      DatabaseValues.dbTaskCompleteDateTime: currentDateTime,
    };

    final Map<String, dynamic> taskCompletedMap = {
      DatabaseValues.dbTaskSampleBy: -1,
    };

    final List<Map<String, Object?>> completedTasks = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskStatusIndex} = 2', whereArgs: [categoryId],);

    for (var task in completedTasks) {
      final TaskModel taskModel = TaskModel.fromMap(task);
      await NotificationService().cancelNotificationWithId(taskModel.notificationId);
    }

    await database.update(DatabaseValues.dbTaskTableName, taskCanceledMap, where: '${DatabaseValues.dbTaskSampleBy} = ? AND ${DatabaseValues.dbTaskEndDateTime} < ? AND ${DatabaseValues.dbTaskStatusIndex} != 1', whereArgs: [categoryId, currentDateTime]);
    await database.update(DatabaseValues.dbTaskTableName, taskCompletedMap, where: '${DatabaseValues.dbTaskSampleBy} = ? AND ${DatabaseValues.dbTaskEndDateTime} < ? AND ${DatabaseValues.dbTaskStatusIndex} = 1', whereArgs: [categoryId, currentDateTime]);
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskSampleBy} = ? AND ${DatabaseValues.dbTaskStartDateTime} <= ? AND ${DatabaseValues.dbTaskEndDateTime} >= ?', whereArgs: [categoryId, currentDateTime, currentDateTime], orderBy: 'CASE WHEN ${DatabaseValues.dbTaskStatusIndex} = 1 THEN 1 ELSE 0 END, $orderBy');
    final List<TaskEntity> taskByCategoryId = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return taskByCategoryId;
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
    final List<Map<String, Object?>> taskSampleByLength = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskSampleBy} = ?', whereArgs: [categoryId]);
    return taskSampleByLength.length;
  }

  @override
  Future<List<TaskEntity>> getTaskByStatus({required int taskStatusIndex}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = taskStatusIndex == 3 ? await database.query(DatabaseValues.dbTaskTableName) : await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskStatusIndex} = ?', whereArgs: [taskStatusIndex]);
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
