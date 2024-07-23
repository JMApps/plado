import 'package:sqflite/sqflite.dart';

import '../../core/styles/app_styles.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_count_model.dart';
import '../models/task_model.dart';
import '../services/plado_database_service.dart';

class TaskDataRepository implements TaskRepository {
  final PladoDatabaseService _pladoDatabaseService = PladoDatabaseService();
  final String _tasksTableName = 'Table_of_tasks';
  final String _taskId = 'task_id';
  final String _taskStatusIndex = 'task_status_index';
  final String _taskPeriodIndex = 'task_period_index';

  @override
  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, orderBy: orderBy);
    final List<TaskEntity> allTasks = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return allTasks;
  }

  @override
  Future<TaskEntity> getTaskById({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: '$_taskId = ?', whereArgs: [taskId]);
    final TaskEntity? taskById = resources.isNotEmpty ? TaskEntity.fromModel(TaskModel.fromMap(resources.first)) : null;
    return taskById!;
  }

  @override
  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String startTime, required String endTime, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final Map<String, dynamic> taskStatusMap = {
      _taskStatusIndex: 2,
      'complete_date_time': endTime,
    };
    await database.update(_tasksTableName, taskStatusMap, where: 'end_date_time < ? AND $_taskPeriodIndex = $taskPeriodIndex', whereArgs: [endTime]);
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: '$_taskPeriodIndex = ? AND start_date_time = ? AND end_date_time = ?', whereArgs: [taskPeriodIndex, startTime, endTime], orderBy: 'CASE WHEN $_taskStatusIndex = 1 THEN 1 ELSE 0 END, $orderBy');
    final List<TaskEntity> tasksByMode = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return tasksByMode;
  }

  @override
  Future<TaskCountModel> getTasksNumber({required int taskPeriodIndex}) async {
    final Database database = await _pladoDatabaseService.db;

    final List<Map<String, Object?>> inProgress = await database.query(
      _tasksTableName,
      where: '$_taskStatusIndex = ? AND $_taskPeriodIndex = ?',
      whereArgs: [0, taskPeriodIndex],
    );

    final List<Map<String, Object?>> complete = await database.query(
      _tasksTableName,
      where: '$_taskStatusIndex = ? AND $_taskPeriodIndex = ?',
      whereArgs: [1, taskPeriodIndex],
    );

    final List<Map<String, Object?>> canceled = await database.query(
      _tasksTableName,
      where: '$_taskStatusIndex = ? AND $_taskPeriodIndex = ?',
      whereArgs: [2, taskPeriodIndex],
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
    final int createTask = await database.insert(_tasksTableName, taskMap, conflictAlgorithm: ConflictAlgorithm.ignore);
    return createTask;
  }

  @override
  Future<int> updateTask({ required int taskId, required Map<String, dynamic> taskMap}) async {
    final Database database = await _pladoDatabaseService.db;
    final int updateTask = await database.update(_tasksTableName, taskMap, where: '$_taskId = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.replace);
    return updateTask;
  }

  @override
  Future<int> deleteTask({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int deleteTask = await database.delete(_tasksTableName, where: '$_taskId = ?', whereArgs: [taskId]);
    return deleteTask;
  }

  @override
  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime}) async {
    final Database database = await _pladoDatabaseService.db;

    final getTaskStatusIndex = AppStyles.taskStatusList[taskStatusIndex].index;
    final Map<String, dynamic> taskStatusMap = {
      _taskStatusIndex: getTaskStatusIndex,
      'complete_date_time': completeDateTime,
    };

    final int statusTask = await database.update(_tasksTableName, taskStatusMap, where: '$_taskId = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.replace);
    return statusTask;
  }
}
