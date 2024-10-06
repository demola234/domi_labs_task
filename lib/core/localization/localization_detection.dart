import 'package:domi_id/core/localization/generated/strings.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// Localization State
enum Localization { en, es, fr, nl, zh }

// Localization Cubit that persists state using HydratedCubit
class LocalizationCubit extends HydratedCubit<Localization> {
  // Change localization
  void changeLocalization(Localization newLocale) {
    emit(newLocale);
  }

  LocalizationCubit() : super(Localization.en);

  // Update the localization
  void updateLocalization(Localization locale) {
    emit(locale);
  }

  // Restore state from storage
  @override
  Localization fromJson(Map<String, dynamic> json) {
    final localeString = json['locale'] as String?;
    switch (localeString) {
      case 'es':
        return Localization.es;
      case 'fr':
        return Localization.fr;
      case 'nl':
        return Localization.nl;
      case 'zh':
        return Localization.zh;
      case 'en':
      default:
        return Localization.en;
    }
  }

  // Save state to storage
  @override
  Map<String, dynamic> toJson(Localization state) {
    return {'locale': state.name};
  }
}

// Usage example
void main() {
  final localizationCubit = LocalizationCubit();

  // Update to Spanish
  localizationCubit.updateLocalization(Localization.fr);

  // Listen to changes
  localizationCubit.stream.listen((locale) {
    print('Current Locale: $locale');
  });
}

extension AppLocalizationsX on BuildContext {
  Strings get l10n => Strings.of(this);
}
