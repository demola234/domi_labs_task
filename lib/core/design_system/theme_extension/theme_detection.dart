import 'package:hydrated_bloc/hydrated_bloc.dart';

// Enum representing different theme modes
enum ThemeModeEnum { Light, Dark, System }

// Cubit to manage the theme state
class ThemeCubit extends HydratedCubit<ThemeModeEnum> {
  ThemeCubit() : super(ThemeModeEnum.System);

  // Function to set the theme
  void setTheme(ThemeModeEnum theme) {
    emit(theme);
  }

  // Method to convert ThemeModeEnum to JSON
  @override
  Map<String, dynamic>? toJson(ThemeModeEnum state) {
    return {'theme': state.index};
  }

  // Method to convert JSON to ThemeModeEnum
  @override
  ThemeModeEnum? fromJson(Map<String, dynamic> json) {
    final index = json['theme'] as int?;
    if (index != null) {
      return ThemeModeEnum
          .values[index.clamp(0, ThemeModeEnum.values.length - 1)];
    }
    return ThemeModeEnum.System;
  }
}
