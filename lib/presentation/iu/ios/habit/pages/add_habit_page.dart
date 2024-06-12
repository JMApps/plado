import 'package:flutter/cupertino.dart';

import '../../../../../core/strings/app_strings.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(AppStrings.addingHabit),
        previousPageTitle: AppStrings.main,
      ),
      child: Container(),
    );
  }
}
