import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMarkerWidget extends StatelessWidget {
  final String address;
  final double price;

  const CustomMarkerWidget({
    super.key,
    required this.address,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
          decoration: BoxDecoration(
            color: context.theme.colors.textPrimary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            address,
            style: context.theme.fonts.bodyMedium.copyWith(
              color: context.theme.colors.textWhite,
              fontSize: 12.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
          decoration: BoxDecoration(
            color: context.theme.colors.textPrimary,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            '\$${price.toInt()}/mo',
            style: context.theme.fonts.bodyMedium.copyWith(
              color: context.theme.colors.textWhite,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        SvgPicture.asset(
          "assets/icons/subtract.svg",
          height: 24.h,
          width: 24.h,
        ),
      ],
    );
  }
}
