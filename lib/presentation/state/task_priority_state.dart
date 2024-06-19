import 'package:flutter/material.dart';

import '../../core/enums/task_priority.dart';

class TaskPriorityState extends ChangeNotifier {
  TaskPriority _taskPriority = TaskPriority.low;

  TaskPriority get getTaskPriority => _taskPriority;

  set setTaskPriority(TaskPriority taskPriority) {
    _taskPriority = taskPriority;
    notifyListeners();
  }
}
