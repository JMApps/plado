import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../data/models/category_model.dart';
import '../../../domain/usecases/category_use_case.dart';
import '../../state/category/category_color_state.dart';
import '../../state/category/category_period_state.dart';
import '../../state/category/category_title_state.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () async {
        final String categoryTitle = Provider.of<CategoryTitleState>(context, listen: false).getCategoryTitle.trim();
        final int categoryColorIndex = Provider.of<CategoryColorState>(context, listen: false).getColorIndex;
        final int categoryPeriodIndex = Provider.of<CategoryPeriodState>(context, listen: false).getCategoryPeriodIndex;

        final CategoryModel categoryModel = CategoryModel(
          categoryId: 0,
          categoryTitle: categoryTitle,
          categoryColorIndex: categoryColorIndex,
          categoryPeriodIndex: categoryPeriodIndex,
        );

        if (categoryTitle.isNotEmpty) {
          await Provider.of<CategoryUseCase>(context, listen: false).createCategory(categoryModel: categoryModel);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Text(
        appLocale.add,
        style: AppStyles.mainText,
      ),
    );
  }
}
