import '../../core/strings/app_exception_messages.dart';
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

  Future<List<TaskEntity>> getTasksByMode({required String taskPeriod, required String orderBy}) async {
    try {
      return await _taskRepository.getTasksByMode(taskPeriod: taskPeriod, orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getTasksByModeException} $e');
    }
  }

  Future<List<TaskEntity>> getSearchTasks({required String searchQuery}) async {
    try {
      return await _taskRepository.searchTasks(searchQuery: searchQuery);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getSearchTasksException} $e');
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
}
