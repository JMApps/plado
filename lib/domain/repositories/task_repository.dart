import '../../data/models/counts/all_task_count_model.dart';
import '../../data/models/task_model.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTaskByCategoryId({required int categoryId, required String orderBy});

  Future<List<TaskEntity>> getDailyTask({required String orderBy});

  Future<void> updateExpiredTasks();

  Future<void> updateCompletedTasks();

  Future<void> cancelNotificationsForCompletedTasks();

  Future<void> resetDailyTasks();

  Future<TaskEntity> getTaskById({required int taskId});

  Future<AllTaskCountModel> getAllTaskCount();

  Future<int> getTaskCountByCategoryId({required int categoryId});

  Future<List<TaskEntity>> getTaskByStatus({required int taskStatusIndex});

  Future<int> createTask({required TaskModel taskModel});

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId});

  Future<int> deleteTask({required int taskId});
}
