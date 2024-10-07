import 'package:flutter/services.dart';

class HapticManager {
  // Singleton instance
  static final HapticManager _instance = HapticManager._internal();
  HapticManager._internal();

  factory HapticManager() => _instance;

  // Trigger light vibration
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  // Trigger selection click feedback
  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  // Trigger custom feedback with callback
  static void customFeedback(Function feedbackType) {
    feedbackType();
  }
}
