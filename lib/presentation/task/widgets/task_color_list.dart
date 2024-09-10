import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/task/task_color_state.dart';

class TaskColorList extends StatelessWidget {
  const TaskColorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskColorState>(
      builder: (context, taskColorState, _) {
        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                taskColorState.setColorIndex = index;
              },
              child: CircleAvatar(
                backgroundColor: AppStyles.appColorList[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                child: taskColorState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }
}
