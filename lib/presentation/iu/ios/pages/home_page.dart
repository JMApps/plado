import 'package:flutter/cupertino.dart';

import '../../../../core/routes/name_routes.dart';
import '../../../../core/strings/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(AppStrings.appName),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pushNamed(context, NameRoutes.createTaskPage);
          },
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: Container(),
    );
  }
}
