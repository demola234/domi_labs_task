import 'package:flutter/material.dart';

/// `ThemeExtension` template for custom text styles.
///
/// If your goal is to only change the text color for light/dark mode, I don't see a big benefit from this extension.
/// For the default text style in the Text widget, you can set `textTheme.bodyMedium` in `ThemeData` (example: lib/app_theme.dart).
/// And to set text color for specific widgets, you can use `style: TextStyle(color: Theme.of(context).appColors.error)` or
/// `style: AppTypography.h1.copyWith(color: context.theme.appColors.error)`.
/// 

class AppFontThemeExtension extends ThemeExtension<AppFontThemeExtension> {
  const AppFontThemeExtension({
    required this.headerLarger,
    required this.headerSmall,
    required this.subHeader,
    required this.bodyMedium,
  });

  final TextStyle headerLarger;
  final TextStyle headerSmall;
  final TextStyle subHeader;
  final TextStyle bodyMedium;

  @override
  ThemeExtension<AppFontThemeExtension> copyWith({
    TextStyle? headerLarger,
    TextStyle? headerSmall,
    TextStyle? subHeader,
    TextStyle? bodyMedium,
  }) {
    return AppFontThemeExtension(
      headerLarger: headerLarger ?? this.headerLarger,
      headerSmall: headerSmall ?? this.headerSmall,
      subHeader: subHeader ?? this.subHeader,
      bodyMedium: bodyMedium ?? this.bodyMedium,
    );
  }

  @override
  ThemeExtension<AppFontThemeExtension> lerp(
    covariant ThemeExtension<AppFontThemeExtension>? other,
    double t,
  ) {
    if (other is! AppFontThemeExtension) {
      return this;
    }

    return AppFontThemeExtension(
      headerLarger: TextStyle.lerp(headerLarger, other.headerLarger, t)!,
      headerSmall: TextStyle.lerp(headerSmall, other.headerSmall, t)!,
      subHeader: TextStyle.lerp(subHeader, other.subHeader, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
    );
  }
}
