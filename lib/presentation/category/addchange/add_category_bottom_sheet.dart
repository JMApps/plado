import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/category/category_color_state.dart';
import '../../state/category/category_period_state.dart';
import '../../state/category/category_title_state.dart';
import 'add_category.dart';
import 'category_color_list.dart';
import 'category_period_segment.dart';
import 'category_text_field.dart';

class AddCategoryBottomSheet extends StatelessWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryTitleState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryColorState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryPeriodState(0),
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
            const AddCategory(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
