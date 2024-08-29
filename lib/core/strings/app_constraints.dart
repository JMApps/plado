class AppConstraints {
  static const int dbVersion = 2;
  static const String dbName = 'plado_database.plado.';
  static const String appVersion = '1.0.0+1';

  static const String appLinkIOS = 'https://apps.apple.com/app/plado/id0000000000';
  static const String appLinkAndroid = 'https://play.google.com/store/apps/details?id=jmapps.project.plado';

  static const String appIOSStore = 'https://apps.apple.com/developer/imanil-binyaminov/id1564920953';
  static const String appAndroidStore = 'https://play.google.com/store/apps/dev?id=8649252597553656018';

  static const String telegramChannel = 'https://t.me/jmapps';
  static const String instagramChannel = 'https://www.instagram.com/dev_muslim';

  static const String iOSIconPath = 'assets/icons/appstore.png';
  static const String androidIconPath = 'assets/icons/google-play.png';

  static const String telegramIconPath = 'assets/icons/telegram.png';
  static const String instagramIconPath = 'assets/icons/instagram.png';

  static const String taskStartDateTime = 'task_start_date_time';
  static const String taskRemaininDateTime = 'task_remaining_date_time';
  static const String taskElapsedPercentage = 'task_elapsed_percentage';
  static const String taskEndDateTime = 'task_end_date_time';

  static const String habitStartDateTime = 'habit_start_date_time';
  static const String habitEndDateTime = 'habit_end_date_time';

  static const String restRemainingDays = 'rest_remainin_days';
  static const String restElapsedDays = 'rest_elapsed_days';
  static const String restRemainingPercentage = 'rest_remaining_percentage';
  static const String restElapsedPercentage = 'rest_elapsed_percentage';

  static const String fontRaleway = 'Raleway';
  static const String fontRobotoSlab = 'Roboto Slab';

  static const int randomNotificationNumber = 1000000;

  static const String ascSort = 'ASC';
  static const String descSort = 'DESC';

  static const String dateFormat = 'dd.MM.yyyy';
  static const String dateTimeFormat = 'dd.MM.yyyy / HH.mm';

  static const String startSeason = 'start_season';
  static const String endSeason = 'end_season';

  static const String googlePlay = 'Google Play';
  static const String appStore = 'App Store';
  static const String telegram = 'Telegram';
  static const String instagram = 'Instagram';

  static const List<String> appLanguages = [
    'Русский',
    'English',
    'Türkçe',
    'Indonesian',
    'Azərbaycan dili',
    'Français',
    'Italiano',
    'Oʻzbekcha',
    'Қазақша',
    'Тоҷикӣ',
    'ქართული',
    'Українська',
  ];

  static const String keyMainAppSettingsBox = 'key_main_app_settings_box';
  static const String keyLocaleIndex = 'key_locale_index';
  static const String keyThemeIndex = 'key_theme_index';
  static const String keyAlwaysOnDisplay = 'key_always_on_display';
  static const String keyColorThemeIndex = 'key_color_theme_index';

  static const String keyTaskSortIndex = 'key_task_sort_index';
  static const String keyTaskOrderIndex = 'key_task_order_index';

  static const String keyHabitSortIndex = 'key_habit_sort_index';
  static const String keyHabitOrderIndex = 'key_habit_order_index';
}