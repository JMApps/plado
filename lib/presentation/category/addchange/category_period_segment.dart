import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/category_period.dart';
import '../../state/category/category_period_state.dart';

class CategoryPeriodSegment extends StatelessWidget {
  const CategoryPeriodSegment({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<CategoryPeriodState>(
      builder: (context, categoryPeriodState, _) {
        return SegmentedButton(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: CategoryPeriod.day.index,
              label: Text(
                appLocale.day,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.day,
            ),
            ButtonSegment(
              value: CategoryPeriod.week.index,
              label: Text(
                appLocale.week,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.week,
            ),
            ButtonSegment(
              value: CategoryPeriod.month.index,
              label: Text(
                appLocale.month,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.month,
            ),
            ButtonSegment(
              value: CategoryPeriod.season.index,
              label: Text(
                appLocale.season,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.season,
            ),
            ButtonSegment(
              value: CategoryPeriod.year.index,
              label: Text(
                appLocale.year,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.year,
            ),
          ],
          selected: {categoryPeriodState.getCategoryPeriodIndex},
          onSelectionChanged: (newIndex) {
            categoryPeriodState.setCategoryPeriodIndex = newIndex.first;
          },
        );
      },
    );
  }
}
