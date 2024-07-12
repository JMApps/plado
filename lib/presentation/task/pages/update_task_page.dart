import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/task_data_state.dart';
import '../../../domain/entities/task_entity.dart';
import '../../state/rest_times_state.dart';
import '../../state/update_task_state.dart';
import '../../widgets/main_back_button.dart';

class UpdateTaskPage extends StatefulWidget {
  const UpdateTaskPage({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late final TextEditingController _taskTextController;
  final _notificationService = NotificationService();
  DateTime _currentTime = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _taskTextController = TextEditingController(text: widget.taskModel.taskTitle);
  }

  @override
  void dispose() {
    _taskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskDataState = Provider.of<TaskDataState>(context, listen: false);
    final appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UpdateTaskState(
            taskPeriod: AppStyles.taskPeriodList[widget.taskModel.taskPeriodIndex],
            taskPriority: AppStyles.taskPriorityList[widget.taskModel.taskPriorityIndex],
            taskStatus: AppStyles.taskStatusList[widget.taskModel.taskStatusIndex],
            colorIndex: widget.taskModel.taskColorIndex,
            taskNotificationDate: DateTime.parse(widget.taskModel.notificationDate!),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestTimesState(
            day: AppStrings.shortDay,
            hour: AppStrings.shortHour,
            minute: AppStrings.shortMinute,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.updatingTask),
          leading: const MainBackButton(),
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Text('Update')
        ),
      ),
    );
  }
}
