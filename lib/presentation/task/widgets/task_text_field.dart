import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../state/task/task_title_state.dart';

class TaskTextField extends StatefulWidget {
  const TaskTextField({super.key});

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  late final TextEditingController _taskTitleController;

  @override
  void initState() {
    super.initState();
    _taskTitleController = TextEditingController(text: context.read<TaskTitleState>().getTaskTitle);
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskTitleState>(
      builder: (context, taskTitleState, _) {
        return TextField(
          controller: _taskTitleController,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLength: 75,
          decoration: const InputDecoration(
            hintText: AppStrings.taskHint,
          ),
          onChanged: (String inputValue) {
            taskTitleState.setTaskTitle = inputValue;
          },
        );
      },
    );
  }
}
