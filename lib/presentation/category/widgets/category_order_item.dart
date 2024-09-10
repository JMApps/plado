import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/category/category_sort_state.dart';

class CategoryOrderItem extends StatelessWidget {
  const CategoryOrderItem({
    super.key,
    required this.title,
    required this.orderIndex,
  });

  final String title;
  final int orderIndex;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final sortState = Provider.of<CategorySortState>(context);
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      shape: AppStyles.shape,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: sortState.getOrderIndex == orderIndex ? appColors.primary : appColors.onSurface,
        ),
      ),
      trailing: sortState.getOrderIndex == orderIndex ? Icon(Icons.check_rounded, color: appColors.primary) : const SizedBox(),
      onTap: () {
        sortState.setOrderIndex = orderIndex;
      },
    );
  }
}
