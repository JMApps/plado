
import '../../data/models/all_task_count_model.dart';
import '../../data/models/task_count_model.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class TaskUseCase {
  final TaskRepository _taskRepository;

  TaskUseCase(this._taskRepository);

  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    return await _taskRepository.getAllTasks(orderBy: orderBy);
  }

  Future<TaskEntity> getTaskById({required int taskId}) async {
    return await _taskRepository.getTaskById(taskId: taskId);
  }

  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String startTime, required String endTime, required String orderBy}) async {
    return await _taskRepository.getTasksByMode(taskPeriodIndex: taskPeriodIndex, startTime: startTime, endTime: endTime, orderBy: orderBy);
  }

  Future<AllTaskCountModel> getAllTasksNumber() async {
    return await _taskRepository.getAllTasksNumber();
  }

  Future<TaskCountModel> getTasksNumber({required int taskPeriodIndex}) async {
    return await _taskRepository.getTasksNumber(taskPeriodIndex: taskPeriodIndex);
  }

  Future<int> createTask({required Map<String, dynamic> taskMap}) async {
    return await _taskRepository.createTask(taskMap: taskMap);
  }

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId}) async {
    return await _taskRepository.updateTask(taskMap: taskMap, taskId: taskId);
  }

  Future<int> deleteTask({required int taskId}) async {
    return await _taskRepository.deleteTask(taskId: taskId);
  }

  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime}) async {
    return await _taskRepository.changeTaskStatus(taskId: taskId, taskStatusIndex: taskStatusIndex, completeDateTime: completeDateTime);
  }
}
