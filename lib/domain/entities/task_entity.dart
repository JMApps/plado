import '../../core/strings/app_exception_messages.dart';
import '../../data/models/task_model.dart';

class TaskEntity {
  final int taskId;
  final String taskTitle;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String taskPeriod;
  final int taskPriorityIndex;
  final String taskStatus;
  final int taskColorIndex;
  final int remindStatus;
  final int? notificationId;

  TaskEntity({
    required this.taskId,
    required this.taskTitle,
    required this.startDateTime,
    required this.endDateTime,
    required this.taskPeriod,
    required this.taskPriorityIndex,
    required this.taskStatus,
    required this.taskColorIndex,
    required this.remindStatus,
    required this.notificationId,
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
      taskPeriod: model.taskPeriod,
      taskPriorityIndex: model.taskPriorityIndex,
      taskStatus: model.taskStatus,
      taskColorIndex: model.taskColorIndex,
      remindStatus: model.remindStatus,
      notificationId: model.notificationId,
    );
  }
}
