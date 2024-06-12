import 'package:flutter/cupertino.dart';

import '../../../../../../core/strings/app_strings.dart';

class UpdateTaskPage extends StatelessWidget {
  const UpdateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(AppStrings.change),
        previousPageTitle: AppStrings.main,
      ),
      child: Container(),
    );
  }
}
