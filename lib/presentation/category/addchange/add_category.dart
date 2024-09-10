import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../data/models/category_model.dart';
import '../../../domain/usecases/category_use_case.dart';
import '../../state/category/category_color_state.dart';
import '../../state/category/category_period_state.dart';
import '../../state/category/category_title_state.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () async {
        final String categoryTitle = Provider.of<CategoryTitleState>(context, listen: false).getCategoryTitle;
        final int categoryColorIndex = Provider.of<CategoryColorState>(context, listen: false).getColorIndex;
        final int categoryPeriodIndex = Provider.of<CategoryPeriodState>(context, listen: false).getCategoryPeriodIndex;

        final CategoryModel categoryModel = CategoryModel(
          categoryId: 0,
          categoryTitle: categoryTitle,
          categoryColorIndex: categoryColorIndex,
          categoryPeriodIndex: categoryPeriodIndex,
        );

        if (categoryTitle.isNotEmpty) {
          Navigator.of(context).pop();
          await Provider.of<CategoryUseCase>(context, listen: false).createCategory(categoryModel: categoryModel);
        }
      },
      child: Text(
        appLocale.add,
        style: AppStyles.mainText,
      ),
    );
  }
}
