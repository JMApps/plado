import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/habit/habit_sort_state.dart';

class HabitOrderItem extends StatelessWidget {
  const HabitOrderItem({
    super.key,
    required this.title,
    required this.orderIndex,
  });

  final String title;
  final int orderIndex;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final sortState = Provider.of<HabitSortState>(context);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      shape: AppStyles.shape,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: sortState.getOrderIndex == orderIndex ? appColors.primary : appColors.onSurface,
        ),
      ),
      trailing: sortState.getOrderIndex == orderIndex ? const Icon(Icons.check_rounded) : const SizedBox(),
      onTap: () {
        sortState.setOrderIndex = orderIndex;
      },
    );
  }
}
