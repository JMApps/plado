import 'package:flutter/material.dart';

import '../../ios/pages/home_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
