import '../../core/strings/app_exception_messages.dart';

class TaskModel {
  final int taskId;
  final String taskTitle;
  final String taskDescription;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String taskPeriod;
  final int taskPriorityIndex;
  final String taskStatus;
  final int taskColorIndex;

  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.startDateTime,
    required this.endDateTime,
    required this.taskPeriod,
    required this.taskPriorityIndex,
    required this.taskStatus,
    required this.taskColorIndex,
  }) {
    if (startDateTime.isAfter(endDateTime)) {
      throw ArgumentError(AppExceptionMessages.dateIsAfterException);
    }
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['task_id'] as int,
      taskTitle: map['task_title'] as String,
      taskDescription: map['task_description'] as String,
      startDateTime: DateTime.parse(map['start_date_time'] as String),
      endDateTime: DateTime.parse(map['end_date_time'] as String),
      taskPeriod: map['task_period'] as String,
      taskPriorityIndex: map['task_priority_index'] as int,
      taskStatus: map['task_status'] as String,
      taskColorIndex: map['task_color_index'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_title': taskTitle,
      'task_description': taskDescription,
      'start_date_time': startDateTime.toIso8601String(),
      'end_date_time': endDateTime.toIso8601String(),
      'task_period': taskPeriod,
      'task_priority_index': taskPriorityIndex,
      'task_status': taskStatus,
      'task_color_index': taskColorIndex,
    };
  }
}
