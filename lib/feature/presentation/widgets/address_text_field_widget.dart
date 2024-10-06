import 'package:domi_id/core/component/icon_components.dart';
import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/core/utils/textfield_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const AddressTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldComponents(
      hintText: context.l10n.building,
      controller: controller,
      onChanged: onChanged,
      suffixIcon: GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: SvgPicture.asset(
            IconsComponents.gps,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          IconsComponents.location,
          height: 24.h,
          width: 24.w,
        ),
      ),
      keyboardType: TextInputType.streetAddress,
      inputType: TextInputType.streetAddress,
    );
  }
}
