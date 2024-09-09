import '../entities/task_category_entity.dart';
import '../repositories/task_category_repository.dart';

class TaskCategoryUseCase {
  final TaskCategoryRepository _taskCategoryRepository;

  TaskCategoryUseCase(this._taskCategoryRepository);

  Future<List<TaskCategoryEntity>> getTaskCategoryByPeriod({required int periodIndex}) async {
    return await _taskCategoryRepository.getTaskCategoryByPeriod(periodIndex: periodIndex);
  }

  Future<int> addTaskCategory({required Map<String, dynamic> taskCategoryMap}) async {
    return await _taskCategoryRepository.addTaskCategory(taskCategoryMap: taskCategoryMap);
  }

  Future<int> changeTaskCategory({required Map<String, dynamic> taskCategoryMap, required int taskCategoryId}) async {
    return await _taskCategoryRepository.changeTaskCategory(taskCategoryMap: taskCategoryMap, taskCategoryId: taskCategoryId);
  }

  Future<int> deleteTaskCategory({required int taskCategoryId}) async {
    return await deleteTaskCategory(taskCategoryId: taskCategoryId);
  }
}