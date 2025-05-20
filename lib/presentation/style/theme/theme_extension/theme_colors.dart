import 'package:cache_storage_demo/presentation/style/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  factory ThemeColors.light() => const ThemeColors(
        buttonColor: AppColors.buttonLight,
        buttonDisabledColor: AppColors.buttonDisabledLight,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight,
        textColor: AppColors.textLight,
      );

  factory ThemeColors.dark() => const ThemeColors(
        buttonColor: AppColors.buttonDark,
        buttonDisabledColor: AppColors.buttonDisabledDark,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
        textColor: AppColors.textDark,
      );

  final Color buttonColor;
  final Color buttonDisabledColor;
  final Color scaffoldBackgroundColor;
  final Color textColor;
  const ThemeColors({
    required this.buttonColor,
    required this.buttonDisabledColor,
    required this.scaffoldBackgroundColor,
    required this.textColor,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? buttonColor,
    Color? buttonDisabledColor,
    Color? scaffoldBackgroundColor,
    Color? textColor,
  }) {
    return ThemeColors(
      buttonColor: buttonColor ?? this.buttonColor,
      buttonDisabledColor: buttonDisabledColor ?? this.buttonDisabledColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }
    return ThemeColors(
      buttonColor: Color.lerp(
            buttonColor,
            other.buttonColor,
            t,
          ) ??
          buttonColor,
      buttonDisabledColor: Color.lerp(
            buttonDisabledColor,
            other.buttonDisabledColor,
            t,
          ) ??
          buttonDisabledColor,
      scaffoldBackgroundColor: Color.lerp(
            scaffoldBackgroundColor,
            other.scaffoldBackgroundColor,
            t,
          ) ??
          scaffoldBackgroundColor,
      textColor: Color.lerp(
            textColor,
            other.textColor,
            t,
          ) ??
          textColor,
    );
  }
}
