import 'package:flutter/cupertino.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_use_case.dart';
import '../repositories/task_data_repository.dart';

class TaskDataState extends ChangeNotifier {
  final TaskUseCase _taskUseCase = TaskUseCase(TaskDataRepository());

  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    return await _taskUseCase.getAllTasks(orderBy: orderBy);
  }

  Future<TaskEntity> getTaskById({required int taskId}) async {
    return await _taskUseCase.getTaskById(taskId: taskId);
  }

  Future<List<TaskEntity>> getTasksByMode({required String taskPeriod, required String orderBy}) async {
    return await _taskUseCase.getTasksByMode(taskPeriod: taskPeriod, orderBy: orderBy);
  }

  Future<List<TaskEntity>> searchTasks({required String searchQuery}) async {
    return await _taskUseCase.getSearchTasks(searchQuery: searchQuery);
  }

  Future<int> createTask({required Map<String, dynamic> taskMap}) async {
    final int createTask = await _taskUseCase.createTask(taskMap: taskMap);
    notifyListeners();
    return createTask;
  }

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId}) async {
    final int updateTask = await _taskUseCase.updateTask(taskMap: taskMap, taskId: taskId);
    notifyListeners();
    return updateTask;
  }

  Future<int> deleteTask({required int taskId}) async {
    final int deleteTask = await _taskUseCase.deleteTask(taskId: taskId);
    notifyListeners();
    return deleteTask;
  }
}