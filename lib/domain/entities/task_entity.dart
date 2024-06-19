import '../../core/enums/task_period.dart';
import '../../core/enums/task_priority.dart';
import '../../core/enums/task_status.dart';
import '../../core/strings/app_exception_messages.dart';
import '../../data/models/task_model.dart';

class TaskEntity {
  final int taskId;
  final String taskTitle;
  final String? taskDescription;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final TaskPeriod taskPeriod;
  final TaskPriority taskPriority;
  final TaskStatus taskStatus;
  final int taskColor;
  final List<String> taskTags;

  TaskEntity({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.startDateTime,
    required this.endDateTime,
    required this.taskPeriod,
    required this.taskPriority,
    required this.taskStatus,
    required this.taskColor,
    required this.taskTags,
  }) {
    if (startDateTime.isAfter(endDateTime)) {
      throw ArgumentError(AppExceptionMessages.dateIsAfterException);
    }
  }

  factory TaskEntity.fromModel(TaskModel model) {
    return TaskEntity(
      taskId: model.taskId,
      taskTitle: model.taskTitle,
      taskDescription: model.taskDescription,
      startDateTime: model.startDateTime,
      endDateTime: model.endDateTime,
      taskPeriod: model.taskPeriod,
      taskPriority: model.taskPriority,
      taskStatus: model.taskStatus,
      taskColor: model.taskColor,
      taskTags: model.taskTags,
    );
  }
}
