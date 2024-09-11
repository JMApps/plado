import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/all_task_count_model.dart';
import '../models/task_count_model.dart';
import '../models/task_model.dart';
import '../services/plado_database_service.dart';

class TaskDataRepository implements TaskRepository {
  final PladoDatabaseService _pladoDatabaseService;

  TaskDataRepository(this._pladoDatabaseService);

  @override
  Future<TaskEntity> getTaskById({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId]);
    final TaskEntity? taskById = resources.isNotEmpty ? TaskEntity.fromModel(TaskModel.fromMap(resources.first)) : null;
    return taskById!;
  }

  @override
  Future<List<TaskEntity>> getTaskByCategoryId({required int categoryId, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskSampleBy} = ?', whereArgs: [categoryId], orderBy: 'CASE WHEN ${DatabaseValues.dbTaskStatusIndex} = 1 THEN 1 ELSE 0 END, $orderBy');
    final List<TaskEntity> taskByCategoryId = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return taskByCategoryId;
  }

  @override
  Future<List<TaskEntity>> getTaskByStatus({required int statusIndex}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = statusIndex <= 2 ? await database.query(DatabaseValues.dbTaskTableName, where: '${DatabaseValues.dbTaskStatusIndex} = ?', whereArgs: [statusIndex], orderBy: '${DatabaseValues.dbTaskId} DESC') : await database.query(DatabaseValues.dbTaskTableName, orderBy: '${DatabaseValues.dbTaskStatusIndex} ASC, ${DatabaseValues.dbTaskId} DESC');
    final List<TaskEntity> tasksByMode = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return tasksByMode;
  }

  @override
  Future<TaskCountModel> getTaskCategoryCount({required int categoryId}) async {
    final Database database = await _pladoDatabaseService.db;

    final List<Map<String, Object?>> inProgress = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ? AND ${DatabaseValues.dbTaskSampleBy} = ?',
      whereArgs: [0, categoryId],
    );

    final List<Map<String, Object?>> complete = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ? AND ${DatabaseValues.dbTaskSampleBy} = ?',
      whereArgs: [1, categoryId],
    );

    final List<Map<String, Object?>> canceled = await database.query(
      DatabaseValues.dbTaskTableName,
      where: '${DatabaseValues.dbTaskStatusIndex} = ? AND ${DatabaseValues.dbTaskSampleBy} = ?',
      whereArgs: [2, categoryId],
    );

    return TaskCountModel(
      inProgress: inProgress.length,
      complete: complete.length,
      canceled: canceled.length,
    );
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
  Future<int> taskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime}) async {
    final Database database = await _pladoDatabaseService.db;

    final getTaskStatusIndex = AppStyles.taskStatusList[taskStatusIndex].index;
    final Map<String, dynamic> taskStatusMap = {
      DatabaseValues.dbTaskStatusIndex: getTaskStatusIndex,
      DatabaseValues.dbTaskCompleteDateTime: completeDateTime,
    };

    final int statusTask = await database.update(DatabaseValues.dbTaskTableName, taskStatusMap, where: '${DatabaseValues.dbTaskId} = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.replace);
    return statusTask;
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
