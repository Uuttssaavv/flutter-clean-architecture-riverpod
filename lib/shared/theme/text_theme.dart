import 'package:flutter/material.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_project/shared/theme/test_styles.dart';

class TextThemes {
  /// Main text theme

  static TextTheme get textTheme {
    return const TextTheme(
      bodyText1: AppTextStyles.bodyLg,
      bodyText2: AppTextStyles.body,
      subtitle1: AppTextStyles.bodySm,
      subtitle2: AppTextStyles.bodyXs,
      headline1: AppTextStyles.h1,
      headline2: AppTextStyles.h2,
      headline3: AppTextStyles.h3,
      headline4: AppTextStyles.h4,
    );
  }

  /// Dark text theme

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.white),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.white),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.white),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.white),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.primary),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.primary),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.primary),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.primary),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.primary),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.primary),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.primary),
    );
  }
}
