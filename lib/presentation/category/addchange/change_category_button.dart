import 'package:flutter/material.dart';

import '../../../domain/entities/category_entity.dart';
import 'change_category_bottom_sheet.dart';

class ChangeCategoryButton extends StatelessWidget {
  const ChangeCategoryButton({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            child: ChangeCategoryBottomSheet(categoryModel: categoryModel),
          ),
        );
      },
      icon: const Icon(Icons.add_circle_outline_rounded),
    );
  }
}
