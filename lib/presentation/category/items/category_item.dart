import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../addchange/category_options.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryModel,
    required this.index,
  });

  final CategoryEntity categoryModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: () {
          // Open task list page
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => CategoryOptions(categoryModel: categoryModel),
          );
        },
        shape: AppStyles.shape,
        visualDensity: VisualDensity.comfortable,
        title: Text(categoryModel.categoryTitle),
        leading: CircleAvatar(
          radius: 7.5,
          backgroundColor: AppStyles.appColorList[categoryModel.categoryColorIndex],
        ),
        trailing: const Text(
          // Add tasks count
          '0',
          style: AppStyles.mainTextRoboto,
        ),
      ),
    );
  }
}
