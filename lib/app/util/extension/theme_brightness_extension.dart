import 'package:cache_storage_demo/core/arch/widget/common/theme_switcher.dart';
import 'package:flutter/material.dart';

extension ThemeBrightnessExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  void switchThemeBrightness({
    required ThemeMode currentThemeMode,
  }) {
    var newThemeMode = ThemeMode.system;
    switch (currentThemeMode) {
      case ThemeMode.system:
        {
          if (isDarkMode) {
            newThemeMode = ThemeMode.light;
            break;
          }
          newThemeMode = ThemeMode.dark;
          break;
        }
      case ThemeMode.light:
        {
          newThemeMode = ThemeMode.dark;
          break;
        }
      case ThemeMode.dark:
        {
          newThemeMode = ThemeMode.light;
          break;
        }
    }

    ThemeModeNotifier.of(this).changeTheme(newThemeMode);
  }
}
