import 'package:flutter/material.dart';

class L10n {
  L10n._();

  static final all = [
    const Locale('en'),
    const Locale('es'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'nl':
        return 'Dutch';
      case 'zh':
        return 'Chinese';
      case 'en':
      default:
        return 'English';
    }
  }
}
