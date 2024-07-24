import '../../core/strings/database_values.dart';

class TaskModel {
  final int taskId;
  final String taskTitle;
  final String createDateTime;
  final String completeDateTime;
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
      createDateTime: map[DatabaseValues.dbTaskCreateDateTime] as String,
      completeDateTime: map[DatabaseValues.dbTaskCompleteDateTime] as String,
      startDateTime: map[DatabaseValues.dbTaskStartDateTime] as String,
      endDateTime: map[DatabaseValues.dbTaskEndDateTime] as String,
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
