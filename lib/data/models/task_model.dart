class TaskModel {
  final int taskId;
  final String taskTitle;
  final String startDateTime;
  final String endDateTime;
  final int taskPeriodIndex;
  final int taskPriorityIndex;
  final int taskStatusIndex;
  final int taskColorIndex;
  final int notificationId;
  final String notificationDate;

  TaskModel({
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
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['task_id'] as int,
      taskTitle: map['task_title'] as String,
      startDateTime: map['start_date_time'] as String,
      endDateTime: map['end_date_time'] as String,
      taskPeriodIndex: map['task_period'] as int,
      taskPriorityIndex: map['task_priority_index'] as int,
      taskStatusIndex: map['task_status'] as int,
      taskColorIndex: map['task_color_index'] as int,
      notificationId: map['notification_id'] as int,
      notificationDate: map['notification_date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_title': taskTitle,
      'start_date_time': startDateTime,
      'end_date_time': endDateTime,
      'task_period': taskPeriodIndex,
      'task_priority_index': taskPriorityIndex,
      'task_status': taskStatusIndex,
      'task_color_index': taskColorIndex,
      'notification_id': notificationId,
      'notification_date': notificationDate,
    };
  }
}
