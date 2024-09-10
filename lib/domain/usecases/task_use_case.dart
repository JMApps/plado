import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';
import '../../data/models/all_task_count_model.dart';
import '../../data/models/task_count_model.dart';
import '../../data/models/task_model.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class TaskUseCase extends ChangeNotifier {
  final TaskRepository _taskRepository;

  TaskUseCase(this._taskRepository);

  String _errorMessage = '';

  String get getErrorMessage => _errorMessage;

  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    try {
      return await _taskRepository.getAllTasks(orderBy: orderBy);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<TaskEntity> getTaskById({required int taskId}) async {
    try {
      return await _taskRepository.getTaskById(taskId: taskId);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String startTime, required String endTime, required String orderBy}) async {
    try {
      return await _taskRepository.getTasksByMode(taskPeriodIndex: taskPeriodIndex, startTime: startTime, endTime: endTime, orderBy: orderBy);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<List<TaskEntity>> getTaskByStatus({required int statusIndex}) async {
    try {
      return await _taskRepository.getTasksByStatus(statusIndex: statusIndex);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<AllTaskCountModel> getAllTasksNumber() async {
    try {
      return await _taskRepository.getAllTasksNumber();
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<TaskCountModel> getTasksNumber({required int taskPeriodIndex}) async {
    try {
      return await _taskRepository.getTasksNumber(taskPeriodIndex: taskPeriodIndex);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime}) async {
    try {
      final int changeTaskStatus = await _taskRepository.changeTaskStatus(taskId: taskId, taskStatusIndex: taskStatusIndex, completeDateTime: completeDateTime);
      notifyListeners();
      return changeTaskStatus;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> createTask({required TaskModel taskModel}) async {
    try {
      final int createTask = await _taskRepository.createTask(taskModel: taskModel);
      notifyListeners();
      return createTask;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId}) async {
    try {
      final int updateTask = await _taskRepository.updateTask(taskMap: taskMap, taskId: taskId);
      notifyListeners();
      return updateTask;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> deleteTask({required int taskId}) async {
    try {
      final int deleteTask = await _taskRepository.deleteTask(taskId: taskId);
      notifyListeners();
      return deleteTask;
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }
}
