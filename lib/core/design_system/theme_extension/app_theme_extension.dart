import 'package:domi_id/core/design_system/font_extension/font_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';
import '../color_extension/app_color_extension.dart';

class AppTheme {
  //
  // Light theme for Synergyy
  //
  static final light = () {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      colorScheme: _lightAppColors.toColorScheme(Brightness.light),
      scaffoldBackgroundColor: _lightAppColors.surface,
      appBarTheme: AppBarTheme(
        color: _lightAppColors.surface,
      ),
      extensions: [
        _lightAppColors,
        _lightFontTheme,
      ],
    );
  }();

  static final _lightFontTheme = AppFontThemeExtension(
    headerLarger: GoogleFonts.figtree(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: _lightAppColors.textPrimary,
    ),
    headerSmall: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: _lightAppColors.textPrimary,
    ),
    subHeader: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: _lightAppColors.textTertiary,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: _lightAppColors.textPrimary,
    ),
  );

  static const _lightAppColors = AppColorExtension(
    textPrimary: AppColor.textPrimary,
    textTertiary: AppColor.textTertiary,
    surfaceCard: AppColor.surfaceCard,
    textHighlightBlue: AppColor.textHighlightBlue,
    surface: AppColor.surface,
    inactiveButton: AppColor.inactiveButton,
    activeButton: AppColor.activeButton,
    textWhite: AppColor.textWhite,
    iconRed: AppColor.iconRed,
    iconBlue: AppColor.iconBlue,
    buttonTertiary: AppColor.buttonTertiary,
    buttonSecondary: AppColor.buttonSecondary,
  );
}

extension ThemeGetter on BuildContext {
  // Usage example: `context.theme`
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension AppThemeExtension on ThemeData {
  AppColorExtension get colors =>
      extension<AppColorExtension>() ?? AppTheme._lightAppColors;

  AppFontThemeExtension get fonts =>
      extension<AppFontThemeExtension>() ?? AppTheme._lightFontTheme;
}
