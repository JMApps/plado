import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/category/category_color_state.dart';

class CategoryColorList extends StatelessWidget {
  const CategoryColorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryColorState>(
      builder: (context, categoryColorState, _) {
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
                categoryColorState.setColorIndex = index;
              },
              child: CircleAvatar(
                backgroundColor: AppStyles.appColorList[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                child: categoryColorState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }
}
