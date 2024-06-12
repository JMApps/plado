import 'package:flutter/cupertino.dart';

import '../../../../../../core/strings/app_strings.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(AppStrings.addingTask),
        previousPageTitle: AppStrings.main,
      ),
      child: Container(),
    );
  }
}