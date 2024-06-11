import 'package:flutter/cupertino.dart';

import '../../../../core/strings/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(AppStrings.appName),
      ),
      child: Container(),
    );
  }
}
