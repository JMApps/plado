import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_count_model.dart';
import '../models/task_model.dart';
import '../services/plado_database_service.dart';

class TaskDataRepository implements TaskRepository {
  final PladoDatabaseService _pladoDatabaseService = PladoDatabaseService();

  @override
  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, orderBy: orderBy);
    final List<TaskEntity> allTasks = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return allTasks;
  }

  @override
  Future<TaskEntity> getTaskById({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId]);
    final TaskEntity? taskById = resources.isNotEmpty ? TaskEntity.fromModel(TaskModel.fromMap(resources.first)) : null;
    return taskById!;
  }

  @override
  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String startTime, required String endTime, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final Map<String, dynamic> taskStatusMap = {
      DatabaseValues.dbTaskStatusIndex: 2,
      DatabaseValues.dbTaskCompleteDateTime: endTime,
    };
    await database.update(DatabaseValues.dbTaskTableName, taskStatusMap, where: '${DatabaseValues.dbTaskPeriodIndex} = ? AND ${DatabaseValues.dbTaskEndDateTime} < ?', whereArgs: [endTime, taskPeriodIndex]);

    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskPeriodIndex} = ? AND ${DatabaseValues.dbTaskStartDateTime} = ? AND ${DatabaseValues.dbTaskEndDateTime} = ?', whereArgs: [taskPeriodIndex, startTime, endTime], orderBy: 'CASE WHEN ${DatabaseValues.dbTaskStatusIndex} = 1 THEN 1 ELSE 0 END, $orderBy');
    final List<TaskEntity> tasksByMode = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return tasksByMode;
  }

  @override
  Future<TaskCountModel> getTasksNumber({required int taskPeriodIndex}) async {
    final Database database = await _pladoDatabaseService.db;

    final List<Map<String, Object?>> inProgress = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ? AND ${DatabaseValues.dbTaskPeriodIndex} = ?',
      whereArgs: [0, taskPeriodIndex],
    );

    final List<Map<String, Object?>> complete = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ? AND ${DatabaseValues.dbTaskPeriodIndex} = ?',
      whereArgs: [1, taskPeriodIndex],
    );

    final List<Map<String, Object?>> canceled = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ? AND ${DatabaseValues.dbTaskPeriodIndex} = ?',
      whereArgs: [2, taskPeriodIndex],
    );

    return TaskCountModel(
      inProgress: inProgress.length,
      complete: complete.length,
      canceled: canceled.length,
    );
  }


  @override
  Future<TaskCountModel> getAllTasksNumber() async {
    final Database database = await _pladoDatabaseService.db;

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

    return TaskCountModel(
      inProgress: inProgress.length,
      complete: complete.length,
      canceled: canceled.length,
    );
  }

  @override
  Future<int> createTask({required Map<String, dynamic> taskMap}) async {
    final Database database = await _pladoDatabaseService.db;
    final int createTask = await database.insert(DatabaseValues.dbTaskTableName, taskMap);
    return createTask;
  }

  @override
  Future<int> updateTask({ required int taskId, required Map<String, dynamic> taskMap}) async {
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

  @override
  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime}) async {
    final Database database = await _pladoDatabaseService.db;

    final getTaskStatusIndex = AppStyles.taskStatusList[taskStatusIndex].index;
    final Map<String, dynamic> taskStatusMap = {
      DatabaseValues.dbTaskStatusIndex: getTaskStatusIndex,
      DatabaseValues.dbTaskCompleteDateTime: completeDateTime,
    };

    final int statusTask = await database.update(DatabaseValues.dbTaskTableName, taskStatusMap, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.replace);
    return statusTask;
  }
}
