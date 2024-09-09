class TaskCategoryEntity {
  final int taskCategoryId;
  final String taskCategoryTitle;
  final int taskCategoryColorIndex;
  final int taskCategoryPeriodIndex;

  TaskCategoryEntity({
    required this.taskCategoryId,
    required this.taskCategoryTitle,
    required this.taskCategoryColorIndex,
    required this.taskCategoryPeriodIndex,
  });
}
