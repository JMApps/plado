import '../../core/strings/app_exception_messages.dart';
import '../../data/models/task_model.dart';

class TaskEntity {
  final int taskId;
  final String taskTitle;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int taskPeriodIndex;
  final int taskPriorityIndex;
  final int taskStatusIndex;
  final int taskColorIndex;
  final int notificationId;
  final DateTime? notificationDate;

  TaskEntity({
    required this.taskId,
    required this.taskTitle,
    required this.startDateTime,
    required this.endDateTime,
    required this.taskPeriodIndex,
    required this.taskPriorityIndex,
    required this.taskStatusIndex,
    required this.taskColorIndex,
    required this.notificationId,
    required this.notificationDate,
  }) {
    if (startDateTime.isAfter(endDateTime)) {
      throw ArgumentError(AppExceptionMessages.dateIsAfterException);
    }
  }

  factory TaskEntity.fromModel(TaskModel model) {
    return TaskEntity(
      taskId: model.taskId,
      taskTitle: model.taskTitle,
      startDateTime: model.startDateTime,
      endDateTime: model.endDateTime,
      taskPeriodIndex: model.taskPriorityIndex,
      taskPriorityIndex: model.taskPriorityIndex,
      taskStatusIndex: model.taskStatusIndex,
      taskColorIndex: model.taskColorIndex,
      notificationId: model.notificationId,
      notificationDate: model.notificationDate,
    );
  }
}
