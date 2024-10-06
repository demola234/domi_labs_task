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
    final Paint thumbPaint = Paint()..color = AppColor.surfaceCard;

    Rect trackRect = Rect.fromLTWH(0, size.height / 2 - 28, size.width, 56);
    RRect trackRRect =
        RRect.fromRectAndRadius(trackRect, const Radius.circular(4));
    canvas.drawRRect(trackRRect, trackPaint);

    Rect fillRect =
        Rect.fromLTWH(0, size.height / 2 - 28, size.width * value, 56);
    RRect fillRRect =
        RRect.fromRectAndRadius(fillRect, const Radius.circular(4));
    canvas.drawRRect(fillRRect, fillPaint);

    double thumbX = size.width * value;
    Rect thumbRect = Rect.fromCenter(
      center: Offset(thumbX, size.height / 2),
      width: 24,
      height: 80,
    );
    RRect thumbRRect =
        RRect.fromRectAndRadius(thumbRect, const Radius.circular(4));
    canvas.drawRRect(thumbRRect, thumbPaint);

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
