import 'package:sqflite/sqflite.dart';

import '../../core/enums/task/task_mode.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';
import '../services/plado_database_service.dart';

class TaskDataRepository implements TaskRepository {
  final PladoDatabaseService _pladoDatabaseService = PladoDatabaseService();
  final String _tasksTableName = 'Table_of_tasks';

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
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: 'task_id = ?', whereArgs: [taskId],);
    final TaskEntity? taskById = resources.isNotEmpty ? TaskEntity.fromModel(TaskModel.fromMap(resources.first)) : null;
    return taskById!;
  }

  @override
  Future<List<TaskEntity>> getTasksByMode({required TaskMode taskMode, required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: 'task_mode = ?', whereArgs: [taskMode.toString()], orderBy: orderBy,);
    final List<TaskEntity> tasksByMode = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return tasksByMode;
  }

  @override
  Future<List<TaskEntity>> searchTasks({required String searchQuery}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: 'task_title MATCH ? OR task_description MATCH ?', whereArgs: [searchQuery, searchQuery],);
    final List<TaskEntity> searchResult = resources.isNotEmpty ? resources.map((e) => TaskEntity.fromModel(TaskModel.fromMap(e))).toList() : [];
    return searchResult;
  }

  @override
  Future<int> createTask({required Map<String, dynamic> task}) async {
    final Database database = await _pladoDatabaseService.db;
    final int taskId = await database.insert(_tasksTableName, task, conflictAlgorithm: ConflictAlgorithm.ignore,);
    return taskId;
  }

  @override
  Future<int> updateTask({required Map<String, dynamic> task, required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int rowsAffected = await database.update(_tasksTableName, task, where: 'task_id = ?', whereArgs: [taskId], conflictAlgorithm: ConflictAlgorithm.ignore,);
    return rowsAffected;
  }

  @override
  Future<int> deleteTask({required int taskId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int rowsDeleted = await database.delete(_tasksTableName, where: 'task_id = ?', whereArgs: [taskId],);
    return rowsDeleted;
  }
}
