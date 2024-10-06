// Flutter imports:
import 'package:domi_id/core/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../design_system/theme_extension/app_theme_extension.dart';

class FilledButtonComponent extends StatelessWidget {
  const FilledButtonComponent({
    super.key,
    this.color,
    required this.text,
    this.active = false,
    this.gradient,
    this.icon,
    this.iconRtr,
    this.textColor,
    this.textSize = 16,
    this.borderColor,
    this.fixedSize,
    this.padding,
    required this.onTap,
  });
  final Color? color;
  final String text;
  final bool? active;
  final String? icon;
  final String? iconRtr;
  final Color? textColor;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final bool? gradient;
  final Size? fixedSize;
  final void Function()? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active!
            ? color ?? context.theme.colors.activeButton
            : context.theme.colors.inactiveButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
          side: BorderSide(
            color: active!
                ? borderColor ?? context.theme.colors.surface
                : Colors.transparent,
          ),
        ),
        elevation: 0,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 15.sp,
            ),
        animationDuration: const Duration(milliseconds: 500),
        fixedSize: fixedSize ?? Size(context.screenWidth() - 20, 56.sp),
      ),
      onPressed: active == true ? onTap : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            SvgPicture.asset(
              icon!,
              height: 24.sp,
              width: 24.sp,
            )
          else
            const SizedBox(),
          10.horizontalSpace,
          Text(
            text,
            style: context.theme.fonts.subHeader.copyWith(
              fontSize: textSize,
              fontWeight: FontWeight.w600,
              color: textColor ?? context.theme.colors.textWhite,
              // fontFamily: PropertyConstant.fontLight,
            ),
          ),
          7.horizontalSpace,
          if (iconRtr != null)
            SvgPicture.asset(
              iconRtr!,
              height: 24.sp,
              width: 24.sp,
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
