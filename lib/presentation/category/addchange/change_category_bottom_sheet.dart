import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../../state/category/category_color_state.dart';
import '../../state/category/category_period_state.dart';
import '../../state/category/category_title_state.dart';
import 'category_color_list.dart';
import 'category_period_segment.dart';
import 'category_text_field.dart';
import 'change_category_button.dart';

class ChangeCategoryBottomSheet extends StatelessWidget {
  const ChangeCategoryBottomSheet({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryTitleState(categoryModel.categoryTitle),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryColorState(categoryModel.categoryColorIndex),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryPeriodState(categoryModel.categoryPeriodIndex),
        ),
      ],
      child: SingleChildScrollView(
        padding: AppStyles.paddingWithoutTop,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              appLocale.addingCategory,
              style: AppStyles.mainText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const CategoryTextField(),
            const SizedBox(height: 4),
            const Divider(indent: 16, endIndent: 16),
            const SizedBox(height: 4),
            const CategoryColorList(),
            const SizedBox(height: 4),
            const Divider(indent: 16, endIndent: 16),
            const SizedBox(height: 4),
            const CategoryPeriodSegment(),
            const SizedBox(height: 4),
            const Divider(indent: 16, endIndent: 16),
            const SizedBox(height: 4),
            ChangeCategoryButton(categoryModel: categoryModel),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
