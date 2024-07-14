import 'package:sqflite/sqflite.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';
import '../services/plado_database_service.dart';

class TaskDataRepository implements TaskRepository {
  final PladoDatabaseService _pladoDatabaseService = PladoDatabaseService();
  final String _tasksTableName = 'Table_of_tasks';
  final String _taskId = 'task_id';

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
  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: 'task_period_index = ?', whereArgs: [taskPeriodIndex], orderBy: orderBy);
    final List<TaskEntity> tasksByMode = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return tasksByMode;
  }

  @override
  Future<int> createTask({required Map<String, dynamic> taskMap}) async {
    final Database database = await _pladoDatabaseService.db;
    final int taskId = await database.insert(_tasksTableName, taskMap, conflictAlgorithm: ConflictAlgorithm.ignore);
    return taskId;
  }

  @override
  Future<int> updateTask({ required int taskId, required Map<String, dynamic> taskMap}) async {
    final Database database = await _pladoDatabaseService.db;
    final int rowsAffected = await database.update(_tasksTableName, taskMap, where: '$_taskId = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.replace);
    return rowsAffected;
  }

  @override
  Future<int> deleteTask({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int rowsDeleted = await database.delete(_tasksTableName, where: '$_taskId = ?', whereArgs: [taskId]);
    return rowsDeleted;
  }
}
