
import '../../core/strings/app_exception_messages.dart';
import '../../data/models/task_count_model.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class TaskUseCase {
  final TaskRepository _taskRepository;

  TaskUseCase(this._taskRepository);

  Future<List<TaskEntity>> getAllTasks({required String orderBy}) async {
    try {
      return await _taskRepository.getAllTasks(orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getAllTaskException} $e');
    }
  }

  Future<TaskEntity> getTaskById({required int taskId}) async {
    try {
      return await _taskRepository.getTaskById(taskId: taskId);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getTaskByIdException} $e');
    }
  }

  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String startTime, required String endTime, required String orderBy}) async {
    try {
      return await _taskRepository.getTasksByMode(taskPeriodIndex: taskPeriodIndex, startTime: startTime, endTime: endTime, orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getTasksByModeException} $e');
    }
  }

  Future<TaskCountModel> getTasksNumber({required int taskPeriodIndex}) async {
    try {
      return await _taskRepository.getTasksNumber(taskPeriodIndex: taskPeriodIndex);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getTasksNumberException} $e');
    }
  }

  Future<int> createTask({required Map<String, dynamic> taskMap}) async {
    try {
      return await _taskRepository.createTask(taskMap: taskMap);
    } catch (e) {
      throw Exception('${AppExceptionMessages.createTaskException} $e');
    }
  }

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId}) async {
    try {
      return await _taskRepository.updateTask(taskMap: taskMap, taskId: taskId);
    } catch (e) {
      throw Exception('${AppExceptionMessages.updateTaskException} $e');
    }
  }

  Future<int> deleteTask({required int taskId}) async {
    try {
      return await _taskRepository.deleteTask(taskId: taskId);
    } catch (e) {
      throw Exception('${AppExceptionMessages.deleteTaskException} $e');
    }
  }

  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex}) async {
    try {
      return await _taskRepository.changeTaskStatus(taskId: taskId, taskStatusIndex: taskStatusIndex);
    } catch (e) {
      throw Exception('${AppExceptionMessages.changeStatusTaskException} $e');
    }
  }
}
