import '../../data/models/all_task_count_model.dart';
import '../../data/models/task_count_model.dart';
import '../../data/models/task_model.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<TaskEntity> getTaskById({required int taskId});

  Future<List<TaskEntity>> getTaskByCategoryId({required int categoryId, required String orderBy});

  Future<List<TaskEntity>> getTaskByStatus({required int statusIndex});

  Future<TaskCountModel> getTaskCategoryCount({required int categoryId});

  Future<AllTaskCountModel> getAllTaskCount();

  Future<int> taskStatus({required int taskId, required int taskStatusIndex, required String completeDateTime});

  Future<int> createTask({required TaskModel taskModel});

  Future<int> updateTask({required Map<String, dynamic> taskMap, required int taskId});

  Future<int> deleteTask({required int taskId});
}
