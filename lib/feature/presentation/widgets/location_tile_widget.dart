import 'package:domi_id/core/component/icon_components.dart';
import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/core/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LocationTile extends StatelessWidget {
  final String name;
  final String address;

  const LocationTile({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth() - 20,
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
      decoration: ShapeDecoration(
        color: context.theme.colors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: SvgPicture.asset(
              IconsComponents.location,
              height: 24.h,
              width: 24.w,
            ),
          ),
          const SizedBox(width: 5.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.theme.fonts.bodyMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                address,
                style: context.theme.fonts.bodyMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
