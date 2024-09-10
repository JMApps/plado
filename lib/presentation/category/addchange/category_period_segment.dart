import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_period.dart';
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
              value: TaskPeriod.day.index,
              label: Text(
                appLocale.day,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.day,
            ),
            ButtonSegment(
              value: TaskPeriod.week.index,
              label: Text(
                appLocale.week,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.week,
            ),
            ButtonSegment(
              value: TaskPeriod.month.index,
              label: Text(
                appLocale.month,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.month,
            ),
            ButtonSegment(
              value: TaskPeriod.season.index,
              label: Text(
                appLocale.season,
                overflow: TextOverflow.clip,
              ),
              tooltip: appLocale.season,
            ),
            ButtonSegment(
              value: TaskPeriod.year.index,
              label: Text(
                appLocale.year,
                overflow: TextOverflow.clip,
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
