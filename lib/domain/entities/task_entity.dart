import '../../core/enums/task/task_mode.dart';
import '../../core/enums/task/task_priority.dart';
import '../../core/enums/task/task_status.dart';
import '../../core/strings/app_exception_messages.dart';

class TaskEntity {
  final int id;
  final String taskTitle;
  final String? taskDescription;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final TaskMode taskMode;
  final TaskPriority taskPriority;
  final TaskStatus taskStatus;
  final int taskColor;
  final List<String> taskTags;

  TaskEntity({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.startDateTime,
    required this.endDateTime,
    required this.taskMode,
    required this.taskPriority,
    required this.taskStatus,
    required this.taskColor,
    required this.taskTags,
  }) {
    if (startDateTime.isAfter(endDateTime)) {
      throw ArgumentError(AppExceptionMessages.dateIsAfterException);
    }
  }
}
