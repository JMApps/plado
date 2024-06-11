import '../../core/enums/task/task_mode.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks({required String orderBy});

  Future<TaskEntity> getTaskById({required int taskId});

  Future<List<TaskEntity>> getTasksByMode({required TaskMode taskMode, required String orderBy});

  Future<int> createTask({required Map<String, dynamic> task});

  Future<int> updateTask({required Map<String, dynamic> task, required int taskId});

  Future<int> deleteTask({required int taskId});
}
