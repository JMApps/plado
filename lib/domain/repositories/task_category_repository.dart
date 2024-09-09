
import '../entities/task_category_entity.dart';

abstract class TaskCategoryRepository {
  Future<List<TaskCategoryEntity>> getTaskCategoryByPeriod({required int periodIndex});

  Future<int> addTaskCategory({required Map<String, dynamic> taskCategoryMap});

  Future<int> changeTaskCategory({required Map<String, dynamic> taskCategoryMap, required int taskCategoryId});

  Future<int> deleteTaskCategory({required int taskCategoryId});
}