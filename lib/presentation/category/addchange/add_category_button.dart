import 'package:flutter/material.dart';

import 'add_category_bottom_sheet.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            child: const AddCategoryBottomSheet(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
