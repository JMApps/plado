import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plado/presentation/settings/widgets/app_lang_drop_button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/routes/name_routes.dart';
import '../../core/strings/app_constraints.dart';
import '../../core/styles/app_styles.dart';
import '../state/setting_data_state.dart';
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
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.settings),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: AppStyles.paddingMini,
          child: Consumer<SettingDataState>(
            builder: (context, settingDataState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DescriptionText(text: appLocale.language),
                  const AppLangDropButton(),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.theme),
                  const AppThemeSegment(),
                  const SizedBox(height: 8),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.themeColor),
                  const ColorThemeList(),
                  const SizedBox(height: 16),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.display),
                  const AlwaysDisplaySwitch(),
                  const SizedBox(height: 8),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.otherApplications),
                  SocialListTile(
                    onSettingTap: () {
                      _launchUrl(Platform.isAndroid ? AppConstraints.appAndroidStore : AppConstraints.appIOSStore);
                    },
                    title: Platform.isAndroid ? AppConstraints.googlePlay : AppConstraints.appStore,
                    imagePath: Platform.isAndroid ? AppConstraints.androidIconPath : AppConstraints.iOSIconPath,
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.weInSocials),
                  SocialListTile(
                    onSettingTap: () {
                      _launchUrl(AppConstraints.telegramChannel);
                    },
                    title: AppConstraints.telegram,
                    imagePath: AppConstraints.telegramIconPath,
                  ),
                  SocialListTile(
                    onSettingTap: () {
                      _launchUrl(AppConstraints.instagramChannel);
                    },
                    title: AppConstraints.instagram,
                    imagePath: AppConstraints.instagramIconPath,
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.backup),
                  ShareRateListTile(
                    onSettingTap: () {
                      Navigator.pushNamed(context, NameRoutes.backupDetailPage);
                    },
                    title: appLocale.backup,
                    icon: Icons.backup_outlined,
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.rateApplication),
                  ShareRateListTile(
                    onSettingTap: () {
                      _launchUrl(Platform.isAndroid ? AppConstraints.appLinkAndroid : AppConstraints.appLinkIOS);
                    },
                    title: appLocale.rate,
                    icon: Icons.star_half_sharp,
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.share),
                  ShareRateListTile(
                    onSettingTap: () {
                      Share.share(
                        '${appLocale.fullAppName}\n\n${appLocale.iOSVersion}\n${AppConstraints.appLinkIOS}\n\n${appLocale.androidVersion}\n${AppConstraints.appLinkAndroid}',
                        sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 2 / 2),
                      );
                    },
                    title: appLocale.share,
                    icon: Icons.ios_share_rounded,
                  ),
                  const Divider(indent: 16, endIndent: 16),
                  DescriptionText(text: appLocale.version),
                  const Padding(
                    padding: AppStyles.paddingHorizontalMini,
                    child: Text(
                      AppConstraints.appVersion,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppConstraints.fontRobotoSlab,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    final Uri urlLink = Uri.parse(link);
    await launchUrl(urlLink);
  }
}
