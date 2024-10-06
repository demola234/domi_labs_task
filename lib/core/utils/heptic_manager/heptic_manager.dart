import 'package:flutter/services.dart';

class HapticManager {
  // Trigger light vibration
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  // Trigger medium vibration
  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  // Trigger heavy vibration
  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  // Trigger selection click feedback
  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  // Trigger vibration feedback (platform dependent)
  static void vibrate() {
    HapticFeedback.vibrate();
  }

  // Trigger custom feedback with callback
  static void customFeedback(Function feedbackType) {
    feedbackType();
  }
}
