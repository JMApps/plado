import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/task/task_sort_state.dart';

class TaskSortItem extends StatelessWidget {
  const TaskSortItem({
    super.key,
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final sortState = Provider.of<TaskSortState>(context);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      shape: AppStyles.shape,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: sortState.getSortIndex == index ? appColors.primary : appColors.onSurface,
        ),
      ),
      trailing: sortState.getSortIndex == index ? const Icon(Icons.check_rounded) : const SizedBox(),
      onTap: () {
        sortState.setSortIndex = index;
      },
    );
  }
}
