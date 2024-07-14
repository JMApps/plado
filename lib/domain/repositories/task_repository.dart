import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks({required String orderBy});

  Future<TaskEntity> getTaskById({required int taskId});

  Future<List<TaskEntity>> getTasksByMode({required int taskPeriodIndex, required String orderBy});

  Future<int> createTask({required Map<String, dynamic> taskMap});

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId});

  Future<int> deleteTask({required int taskId});

  Future<int> changeTaskStatus({required int taskId, required int taskStatusIndex});
}
