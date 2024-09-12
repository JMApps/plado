import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';
import '../../data/models/counts/all_task_count_model.dart';
import '../../data/models/task_model.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class TaskUseCase extends ChangeNotifier {
  final TaskRepository _taskRepository;

  TaskUseCase(this._taskRepository);

  Future<List<TaskEntity>> fetchTaskByCategoryId({required int categoryId, required String orderBy}) async {
    try {
      return await _taskRepository.getTaskByCategoryId(categoryId: categoryId, orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<TaskEntity> fetchTaskById({required int taskId}) async {
    try {
      return await _taskRepository.getTaskById(taskId: taskId);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<AllTaskCountModel> fetchAllTaskCount() async {
    try {
      return await _taskRepository.getAllTaskCount();
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> fetchTaskCountByCategoryId({required int categoryId}) async {
    try {
      return await _taskRepository.getTaskCountByCategoryId(categoryId: categoryId);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<List<TaskEntity>> fetchTaskByStatus({required int taskStatusIndex}) async {
    try {
      return await _taskRepository.getTaskByStatus(taskStatusIndex: taskStatusIndex);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> createTask({required TaskModel taskModel}) async {
    try {
      final int createTask = await _taskRepository.createTask(taskModel: taskModel);
      notifyListeners();
      return createTask;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId}) async {
    try {
      final int updateTask = await _taskRepository.updateTask(taskMap: taskMap, taskId: taskId);
      notifyListeners();
      return updateTask;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> deleteTask({required int taskId}) async {
    try {
      final int deleteTask = await _taskRepository.deleteTask(taskId: taskId);
      notifyListeners();
      return deleteTask;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }
}
