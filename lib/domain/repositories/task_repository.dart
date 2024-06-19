
import 'package:plado/core/enums/task_period.dart';

import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks({required String orderBy});

  Future<TaskEntity> getTaskById({required int taskId});

  Future<List<TaskEntity>> getTasksByMode({required TaskPeriod taskPeriod, required String orderBy});

  Future<List<TaskEntity>> searchTasks({required String searchQuery});

  Future<int> createTask({required Map<String, dynamic> task});

  Future<int> updateTask({required Map<String, dynamic> task, required int taskId});

  Future<int> deleteTask({required int taskId});
}
