import '../../core/strings/database_values.dart';

class TaskModel {
  final int taskId;
  final String taskTitle;
  final DateTime createDateTime;
  final DateTime completeDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int taskPeriodIndex;
  final int taskPriorityIndex;
  final int taskStatusIndex;
  final int taskColorIndex;
  final int notificationId;
  final String notificationDate;

  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.createDateTime,
    required this.completeDateTime,
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
      taskId: map[DatabaseValues.dbTaskId] as int,
      taskTitle: map[DatabaseValues.dbTaskTitle] as String,
      createDateTime: DateTime.parse(map[DatabaseValues.dbTaskCreateDateTime]),
      completeDateTime: DateTime.parse(map[DatabaseValues.dbTaskCompleteDateTime]),
      startDateTime: DateTime.parse(map[DatabaseValues.dbTaskStartDateTime]),
      endDateTime: DateTime.parse(map[DatabaseValues.dbTaskEndDateTime]),
      taskPeriodIndex: map[DatabaseValues.dbTaskPeriodIndex] as int,
      taskPriorityIndex: map[DatabaseValues.dbTaskPriorityIndex] as int,
      taskStatusIndex: map[DatabaseValues.dbTaskStatusIndex] as int,
      taskColorIndex: map[DatabaseValues.dbTaskColorIndex] as int,
      notificationId: map[DatabaseValues.dbTaskNotificationId] as int,
      notificationDate: map[DatabaseValues.dbTaskNotificationDate] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseValues.dbTaskId: taskTitle,
      DatabaseValues.dbTaskTitle: createDateTime,
      DatabaseValues.dbTaskCreateDateTime: completeDateTime,
      DatabaseValues.dbTaskCompleteDateTime: startDateTime,
      DatabaseValues.dbTaskStartDateTime: endDateTime,
      DatabaseValues.dbTaskEndDateTime: taskPeriodIndex,
      DatabaseValues.dbTaskPeriodIndex: taskPriorityIndex,
      DatabaseValues.dbTaskPriorityIndex: taskStatusIndex,
      DatabaseValues.dbTaskStatusIndex: taskColorIndex,
      DatabaseValues.dbTaskColorIndex: notificationId,
      DatabaseValues.dbTaskNotificationId: notificationDate,
    };
  }
}
