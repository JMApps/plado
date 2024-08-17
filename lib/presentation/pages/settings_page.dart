import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/strings/app_constraints.dart';
import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../data/state/setting_data_state.dart';
import '../settings/widgets/always_display_switch.dart';
import '../settings/widgets/app_theme_segment.dart';
import '../settings/widgets/color_theme_list.dart';
import '../settings/widgets/share_rate_list_tile.dart';
import '../settings/widgets/social_list_tile.dart';
import '../widgets/description_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: SingleChildScrollView(
        padding: AppStyles.paddingMini,
        child: Consumer<SettingDataState>(
          builder: (context, settingDataState, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DescriptionText(text: AppStrings.theme),
                const AppThemeSegment(),
                const SizedBox(height: 8),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.themeColor),
                const ColorThemeList(),
                const SizedBox(height: 16),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.display),
                const AlwaysDisplaySwitch(),
                const SizedBox(height: 8),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.otherApplications),
                SocialListTile(
                  onSettingTap: () {
                    _launchUrl(Platform.isAndroid ? AppConstraints.appAndroidStore : AppConstraints.appIOSStore);
                  },
                  title: Platform.isAndroid ? AppStrings.googlePlay : AppStrings.appStore,
                  imagePath: Platform.isAndroid ? AppConstraints.androidIconPath : AppConstraints.iOSIconPath,
                ),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.weInSocials),
                SocialListTile(
                  onSettingTap: () {
                    _launchUrl(AppConstraints.telegramChannel);
                  },
                  title: AppStrings.telegram,
                  imagePath: AppConstraints.telegramIconPath,
                ),
                SocialListTile(
                  onSettingTap: () {
                    _launchUrl(AppConstraints.instagramChannel);
                  },
                  title: AppStrings.instagram,
                  imagePath: AppConstraints.instagramIconPath,
                ),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.rateApplication),
                ShareRateListTile(
                  onSettingTap: () {
                    _launchUrl(Platform.isAndroid ? AppConstraints.appLinkAndroid : AppConstraints.appLinkIOS);
                  },
                  title: AppStrings.rate,
                  icon: Icons.star_half_rounded,
                ),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.share),
                ShareRateListTile(
                  onSettingTap: () {
                    Share.share(
                      '${AppStrings.fullAppName}\n\n${AppStrings.iOSVersion}\n${AppConstraints.appLinkIOS}\n\n${AppStrings.androidVersion}\n${AppConstraints.appLinkAndroid}',
                      sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 2 / 2),
                    );
                  },
                  title: AppStrings.share,
                  icon: Icons.ios_share_rounded,
                ),
                const Divider(indent: 16, endIndent: 16),
                const DescriptionText(text: AppStrings.version),
                const DescriptionText(text: AppConstraints.appVersion),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    final Uri urlLink = Uri.parse(link);
    await launchUrl(urlLink);
  }
}
