import 'package:flutter/material.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_project/shared/theme/test_styles.dart';

class TextThemes {
  /// Main text theme

  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodySm,
      titleSmall: AppTextStyles.bodyXs,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  /// Dark text theme

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.white),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.white),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.primary),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.primary),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.primary),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.primary),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.primary),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.primary),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.primary),
    );
  }
}
