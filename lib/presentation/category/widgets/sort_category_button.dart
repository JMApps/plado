import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'category_sort_bottom_sheet.dart';

class SortCategoryButton extends StatelessWidget {
  const SortCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          // Need task category sort
          builder: (_) => const CategorySortBottomSheet(),
        );
      },
      tooltip: appLocale.sortCategoryTasks,
      icon: const Icon(Icons.sort),
    );
  }
}
