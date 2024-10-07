import 'package:domi_id/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderPainter extends CustomPainter {
  final double value;
  final double maxAmount;

  SliderPainter(this.value, this.maxAmount);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()..color = AppColor.inactiveButton;
    final Paint fillPaint = Paint()..color = AppColor.buttonTertiary;

    // Drawing the track of the slider
    Rect trackRect = Rect.fromLTWH(0, size.height / 2 - 28, size.width, 56);
    RRect trackRRect =
        RRect.fromRectAndRadius(trackRect, const Radius.circular(4));
    canvas.drawRRect(trackRRect, trackPaint);

    // Drawing the filled part of the slider
    Rect fillRect =
        Rect.fromLTWH(0, size.height / 2 - 28, size.width * value, 56);
    RRect fillRRect =
        RRect.fromRectAndRadius(fillRect, const Radius.circular(4));
    canvas.drawRRect(fillRRect, fillPaint);

    // Drawing the custom thumb
    double thumbX = size.width * value;
    Size thumbSize = const Size(15, 74); // Size of the custom thumb
    RPSCustomPainter().paint(
      canvas,
      thumbSize, // Size of the thumb
      Offset(thumbX - thumbSize.width / 2,
          size.height / 2 - thumbSize.height / 2), // Position the thumb
    );

    // Drawing the amount text
    double amount = value * maxAmount;

    final textPainter = TextPainter(
      text: TextSpan(
        text: "\$${amount.toStringAsFixed(0)}/mo",
        style: TextStyle(
          color: AppColor.textPrimary,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    double textXPosition = 20;
    textPainter.paint(canvas,
        Offset(textXPosition, size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size, [Offset offset = Offset.zero]) {
    // Drawing the thumb with custom style
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColor.surfaceCard.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              offset.dx + size.width * 0.0096,
              offset.dy + size.height * 0.0054,
              size.width * 0.9807,
              size.height * 0.9891),
          bottomRight: Radius.circular(size.width * 0.2667),
          bottomLeft: Radius.circular(size.width * 0.2667),
          topLeft: Radius.circular(size.width * 0.2667),
          topRight: Radius.circular(size.width * 0.2667),
        ),
        paint0Fill);

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.0333;
    paint1Stroke.color = Colors.black.withOpacity(0.5);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              offset.dx + size.width * 0.0262,
              offset.dy + size.height * 0.0087,
              size.width * 0.9474,
              size.height * 0.9824),
          bottomRight: Radius.circular(size.width * 0.2500),
          bottomLeft: Radius.circular(size.width * 0.2500),
          topLeft: Radius.circular(size.width * 0.2500),
          topRight: Radius.circular(size.width * 0.2500),
        ),
        paint1Stroke);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = AppColor.textWhite.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              offset.dx + size.width * 0.0262,
              offset.dy + size.height * 0.0087,
              size.width * 0.9474,
              size.height * 0.9824),
          bottomRight: Radius.circular(size.width * 0.2500),
          bottomLeft: Radius.circular(size.width * 0.2500),
          topLeft: Radius.circular(size.width * 0.2500),
          topRight: Radius.circular(size.width * 0.2500),
        ),
        paint1Fill);

    // Stroke points inside the filled thumb, moving with the thumb
    Paint paint2Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.0333;
    paint2Stroke.color = Colors.black.withOpacity(0.5);

    double strokeX = size.width * 0.5331 + offset.dx;
    canvas.drawLine(Offset(strokeX, offset.dy + size.height * 0.2027),
        Offset(strokeX, offset.dy + size.height * 0.7812), paint2Stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
