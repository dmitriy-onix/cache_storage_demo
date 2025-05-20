import 'package:cache_storage_demo/presentation/style/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  factory ThemeTextStyles.light() => const ThemeTextStyles(
        button: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.buttonLight,
        ),
        text: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textLight,
        ),
      );

  factory ThemeTextStyles.dark() => const ThemeTextStyles(
        button: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.buttonDark,
        ),
        text: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      );

  final TextStyle? button;
  final TextStyle? text;

  const ThemeTextStyles({
    this.button,
    this.text,
  });

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? button,
    TextStyle? text,
  }) {
    return ThemeTextStyles(
      button: button ?? this.button,
      text: text ?? this.text,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }
    return ThemeTextStyles(
      button: TextStyle.lerp(button, other.button, t),
      text: TextStyle.lerp(text, other.text, t),
    );
  }
}
