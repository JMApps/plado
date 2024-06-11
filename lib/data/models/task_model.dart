import '../../core/enums/task/task_mode.dart';
import '../../core/enums/task/task_priority.dart';
import '../../core/enums/task/task_status.dart';
import '../../core/strings/app_exception_messages.dart';

class TaskModel {
  final int taskId;
  final String taskTitle;
  final String? taskDescription;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final TaskMode taskMode;
  final TaskPriority taskPriority;
  final TaskStatus taskStatus;
  final int taskColor;
  final List<String> taskTags;

  TaskModel({
    required this.taskId,
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

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['task_id'] as int,
      taskTitle: map['task_title'] as String,
      taskDescription: map['task_description'] as String?,
      startDateTime: DateTime.parse(map['start_date_time'] as String),
      endDateTime: DateTime.parse(map['end_date_time'] as String),
      taskMode: map['task_mode'] as TaskMode,
      taskPriority: map['task_priority'] as TaskPriority,
      taskStatus: map['task_status'] as TaskStatus,
      taskColor: map['task_color'] as int,
      taskTags: map['task_tags'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_title': taskTitle,
      'task_description': taskDescription,
      'start_date_time': startDateTime.toIso8601String(),
      'end_date_time': endDateTime.toIso8601String(),
      'task_mode': taskMode,
      'task_priority': taskPriority,
      'task_status': taskStatus,
      'task_color': taskColor,
      'task_tags': taskTags,
    };
  }
}
