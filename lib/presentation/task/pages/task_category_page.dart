import 'package:flutter/material.dart';

import '../../../core/routes/name_routes.dart';
import '../../../data/models/arguments/category_model_args.dart';
import '../../../domain/entities/category_entity.dart';
import '../lists/tasks_main_list.dart';
import '../widgets/task_sort_bottom_sheet.dart';

class TaskCategoryPage extends StatelessWidget {
  const TaskCategoryPage({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.categoryTitle),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const TaskSortBottomSheet(),
              );
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: TasksMainList(categoryModel: categoryModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            NameRoutes.createTaskPage,
            arguments: CategoryModelArgs(
              categoryModel: categoryModel,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
