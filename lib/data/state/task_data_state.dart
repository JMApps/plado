import 'package:flutter/cupertino.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_use_case.dart';
import '../models/task_count_model.dart';
import '../repositories/task_data_repository.dart';

class TaskDataState extends ChangeNotifier {
  final TaskUseCase _taskUseCase = TaskUseCase(TaskDataRepository());

  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    return await _taskUseCase.getAllTasks(orderBy: orderBy);
  }

  Future<TaskEntity> getTaskById({required int taskId}) async {
    return await _taskUseCase.getTaskById(taskId: taskId);
  }

  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String startTime, required String endTime, required String orderBy}) async {
    return await _taskUseCase.getTasksByMode(taskPeriodIndex: taskPeriodIndex, startTime: startTime, endTime: endTime, orderBy: orderBy);
  }

  Future<TaskCountModel> getTasksNumber({required int taskPeriodIndex}) async {
    final TaskCountModel taskCountModel = await _taskUseCase.getTasksNumber(taskPeriodIndex: taskPeriodIndex);
    notifyListeners();
    return taskCountModel;
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

  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime}) async {
    final int statusTask = await _taskUseCase.changeTaskStatus(taskId: taskId, taskStatusIndex: taskStatusIndex, completeDateTime: completeDateTime);
    notifyListeners();
    return statusTask;
  }
}