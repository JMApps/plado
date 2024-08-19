import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';

class BackupDetailPage extends StatelessWidget {
  const BackupDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.backup),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              onTap: () {},
              title: const Text(AppStrings.import),
              subtitle: const Text(AppStrings.selectImportFile),
            ),
            ListTile(
              onTap: () {},
              title: const Text(AppStrings.export),
              subtitle: const Text(AppStrings.selectExportPath),
            ),
          ],
        ),
      ),
    );
  }
}
