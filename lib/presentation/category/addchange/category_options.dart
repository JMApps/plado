import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/category_use_case.dart';
import 'change_category_bottom_sheet.dart';

class CategoryOptions extends StatelessWidget {
  const CategoryOptions({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final appLocale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: AppStyles.paddingWithoutTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
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
            child: Text(
              appLocale.change,
              style: AppStyles.mainText,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  actionsAlignment: MainAxisAlignment.end,
                  alignment: Alignment.center,
                  contentPadding: AppStyles.padding,
                  titlePadding: AppStyles.paddingWithoutBottom,
                  title: Text(
                    appLocale.warning,
                    style: TextStyle(
                      color: appColors.error,
                    ),
                  ),
                  content: Text(
                    appLocale.deleteCategoryContent,
                    style: AppStyles.mainText,
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        appLocale.cancel,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Provider.of<CategoryUseCase>(context, listen: false).deleteTaskCategory(categoryId: categoryModel.categoryId);
                      },
                      child: Text(
                        appLocale.delete,
                        style: TextStyle(
                          color: appColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              appLocale.delete,
              style: AppStyles.mainText,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
