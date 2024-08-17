import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';

class ShareRateListTile extends StatelessWidget {
  const ShareRateListTile({
    super.key,
    required this.onSettingTap,
    required this.title,
    required this.icon,
  });

  final GestureTapCallback onSettingTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onSettingTap,
      shape: AppStyles.shape,
      title: Text(title),
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
