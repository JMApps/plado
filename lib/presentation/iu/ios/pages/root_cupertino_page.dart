import 'package:flutter/cupertino.dart';
import 'package:plado/core/routes/cupertino_routes.dart';

import 'home_page.dart';

class RootCupertinoPage extends StatelessWidget {
  const RootCupertinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CupertinoRoutes.onGenerateRoute,
      home: HomePage(),
    );
  }
}
