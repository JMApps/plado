import '../../core/strings/database_values.dart';

class TaskModel {
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

  TaskModel({
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

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map[DatabaseValues.dbTaskId] as int,
      taskTitle: map[DatabaseValues.dbTaskTitle] as String,
      createDateTime: DateTime.parse(map[DatabaseValues.dbTaskCreateDateTime]),
      completeDateTime: DateTime.parse(map[DatabaseValues.dbTaskCompleteDateTime]),
      taskPriorityIndex: map[DatabaseValues.dbTaskPriorityIndex] as int,
      taskStatusIndex: map[DatabaseValues.dbTaskStatusIndex] as int,
      taskColorIndex: map[DatabaseValues.dbTaskColorIndex] as int,
      taskSampleBy: map[DatabaseValues.dbTaskSampleBy] as int,
      notificationId: map[DatabaseValues.dbTaskNotificationId] as int,
      notificationDate: map[DatabaseValues.dbTaskNotificationDate] as String,
    );
  }

  Map<String, dynamic> taskToMap() {
    return {
      DatabaseValues.dbTaskTitle: taskTitle,
      DatabaseValues.dbTaskCreateDateTime: createDateTime.toIso8601String(),
      DatabaseValues.dbTaskCompleteDateTime: completeDateTime.toIso8601String(),
      DatabaseValues.dbTaskPriorityIndex: taskPriorityIndex,
      DatabaseValues.dbTaskStatusIndex: taskStatusIndex,
      DatabaseValues.dbTaskColorIndex: taskColorIndex,
      DatabaseValues.dbTaskSampleBy: taskSampleBy,
      DatabaseValues.dbTaskNotificationId: notificationId,
      DatabaseValues.dbTaskNotificationDate: notificationDate,
    };
  }
}
