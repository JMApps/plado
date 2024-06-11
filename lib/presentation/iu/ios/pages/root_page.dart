import 'package:flutter/cupertino.dart';

import 'home_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
