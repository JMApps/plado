import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/category_use_case.dart';
import '../../state/category/category_color_state.dart';
import '../../state/category/category_period_state.dart';
import '../../state/category/category_title_state.dart';

class ChangeCategoryButton extends StatelessWidget {
  const ChangeCategoryButton({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () async {
        final String categoryTitle = Provider.of<CategoryTitleState>(context, listen: false).getCategoryTitle;
        final int categoryColorIndex = Provider.of<CategoryColorState>(context, listen: false).getColorIndex;
        final int categoryPeriodIndex = Provider.of<CategoryPeriodState>(context, listen: false).getCategoryPeriodIndex;

        if (categoryTitle.isNotEmpty) {
          if (categoryTitle != categoryModel.categoryTitle || categoryColorIndex != categoryModel.categoryColorIndex || categoryPeriodIndex != categoryModel.categoryPeriodIndex) {
            Navigator.of(context).pop();
            final Map<String, dynamic> categoryMap = {
              DatabaseValues.dbCategoryTitle: categoryTitle,
              DatabaseValues.dbCategoryColorIndex: categoryColorIndex,
              DatabaseValues.dbCategoryPeriodIndex: categoryPeriodIndex,
            };
            await Provider.of<CategoryUseCase>(context, listen: false).updateTaskCategory(categoryMap: categoryMap, categoryId: categoryModel.categoryId);
          } else {
            Navigator.of(context).pop();
          }
        }
      },
      child: Text(
        appLocale.change,
        style: AppStyles.mainText,
      ),
    );
  }
}
