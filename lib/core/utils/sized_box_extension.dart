import 'package:flutter/material.dart';

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension CustomContext on BuildContext {
  /// [screenHeight] is used to get the height of the screen
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  /// [screenWidth] is used to get the width of the screen
  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}
