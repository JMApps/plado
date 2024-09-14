import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/category_use_case.dart';
import '../../state/category/category_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/category_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.taskPeriodIndex,
  });

  final int taskPeriodIndex;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer2<CategoryUseCase, CategorySortState>(
      builder: (BuildContext context, categoryUseCase, categorySortState, _) {
        return FutureBuilder<List<CategoryEntity>>(
          future: Provider.of<CategoryUseCase>(context).fetchCategoriesByPeriod(
            periodIndex: taskPeriodIndex,
            orderBy: '${AppStyles.categorySortList[categorySortState.getSortIndex]} ${AppStyles.orderList[categorySortState.getOrderIndex]}',
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Scrollbar(
                child: ListView.builder(
                  padding: AppStyles.paddingWithoutBottomMini,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final CategoryEntity categoryModel =
                    snapshot.data![index];
                    return CategoryItem(
                      categoryModel: categoryModel,
                      index: index,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return MainErrorText(errorText: snapshot.error.toString());
            } else {
              return SafeArea(
                child: TimeIsEmpty(
                  title: appLocale.addFirstCategory,
                  icon: Icons.category_outlined,
                ),
              );
            }
          },
        );
      },
    );
  }
}
