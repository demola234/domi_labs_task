import 'package:domi_id/core/component/filled_button.dart';
import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/core/utils/sized_box_extension.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_state.dart';
import 'package:domi_id/feature/presentation/bloc/slider_cubit.dart';
import 'package:domi_id/feature/presentation/widgets/head_row_widget.dart';
import 'package:domi_id/feature/presentation/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarnWithDomiIDPage extends StatefulWidget {
  final PageController pageController;
  const EarnWithDomiIDPage({required this.pageController, super.key});

  @override
  State<EarnWithDomiIDPage> createState() => _EarnWithDomiIDPageState();
}

class _EarnWithDomiIDPageState extends State<EarnWithDomiIDPage> {
  String formatEstimatedValue(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(
          2); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderRow(currentPage: 1, pageController: widget.pageController),
            const SizedBox(height: 16.0),
            Text(
              context.l10n.earnWithDomiIDScreen,
              style: context.theme.fonts.headerLarger.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              context.l10n.openMails,
              style: context.theme.fonts.bodyMedium.copyWith(
                fontSize: 16.sp,
                color: context.theme.colors.textTertiary,
              ),
            ),
            SizedBox(height: 20.h),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  context.l10n.yourHomeValue,
                  style: context.theme.fonts.bodyMedium.copyWith(
                    color: context.theme.colors.textTertiary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 5.w),
                BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
                  builder: (context, claimState) {
                    return claimState.maybeWhen(
                        orElse: () => const SizedBox.shrink(),
                        selectedLocation: (selectedLocation, selectedPrice,
                                estimatedPrice, markers) =>
                            BlocBuilder<SliderCubit, double>(
                              builder: (context, sliderValue) {
                                return Text(
                                  '\$${formatEstimatedValue(estimatedPrice != null ? estimatedPrice * sliderValue : 0.0)} (Est.)',
                                  style:
                                      context.theme.fonts.bodyMedium.copyWith(
                                    color: context.theme.colors.textPrimary,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ));
                  },
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Stack(children: [
              Row(
                children: [
                  BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
                    builder: (context, claimState) {
                      return BlocBuilder<SliderCubit, double>(
                        builder: (context, sliderValue) {
                          return GestureDetector(
                              onPanUpdate: (details) {
                                double newValue = (details.localPosition.dx /
                                        context.size!.width)
                                    .clamp(0.0, 1.0);
                                context
                                    .read<SliderCubit>()
                                    .updateValue(newValue);
                              },
                              child: CustomPaint(
                                  size: Size(context.screenWidth(0.8), 80),
                                  painter: SliderPainter(
                                      sliderValue,
                                      claimState.maybeMap(
                                        orElse: () => 0.0,
                                        selectedLocation: (value) =>
                                            value.maybeWhen(
                                                orElse: () => 0.0,
                                                selectedLocation:
                                                    (selectedLocation,
                                                            selectedPrice,
                                                            estimatedPrice,
                                                            markers) =>
                                                        selectedPrice!
                                                            .toDouble()),
                                      ))));
                        },
                      );
                    },
                  ),
                ],
              ),
            ]),
            SizedBox(height: 8.h),
            Text(
              context.l10n.openingDirect,
              style: context.theme.fonts.bodyMedium
                  .copyWith(color: context.theme.colors.activeButton),
            ),
            SizedBox(height: 16.h),
            FilledButtonComponent(
              active: true,
              onTap: () {
                context
                    .read<LocalizationCubit>()
                    .changeLocalization(Localization.en);
              },
              text: context.l10n.claimAddress,
            ),
          ],
        ),
      ),
    );
  }
}
