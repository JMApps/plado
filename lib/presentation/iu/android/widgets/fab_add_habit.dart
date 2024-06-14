import 'package:flutter/material.dart';

import '../../../../core/routes/name_routes.dart';

class FabAddHabit extends StatelessWidget {
  const FabAddHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 0.5,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, NameRoutes.createHabitPage);
      },
    );
  }
}
