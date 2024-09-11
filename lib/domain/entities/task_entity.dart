import '../../data/models/task_model.dart';

class TaskEntity {
  final int taskId;
  final String taskTitle;
  final DateTime createDateTime;
  final DateTime completeDateTime;
  final int taskPriorityIndex;
  final int taskStatusIndex;
  final int taskColorIndex;
  final int taskSampleBy;
  final int notificationId;
  final String notificationDate;

  TaskEntity({
    required this.taskId,
    required this.taskTitle,
    required this.createDateTime,
    required this.completeDateTime,
    required this.taskPriorityIndex,
    required this.taskStatusIndex,
    required this.taskColorIndex,
    required this.taskSampleBy,
    required this.notificationId,
    required this.notificationDate,
  });

  factory TaskEntity.fromModel(TaskModel model) {
    return TaskEntity(
      taskId: model.taskId,
      taskTitle: model.taskTitle,
      createDateTime: model.createDateTime,
      completeDateTime: model.completeDateTime,
      taskPriorityIndex: model.taskPriorityIndex,
      taskStatusIndex: model.taskStatusIndex,
      taskColorIndex: model.taskColorIndex,
      taskSampleBy: model.taskSampleBy,
      notificationId: model.notificationId,
      notificationDate: model.notificationDate,
    );
  }
}
