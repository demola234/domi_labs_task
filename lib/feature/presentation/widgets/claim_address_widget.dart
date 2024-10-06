import 'package:domi_id/core/component/filled_button.dart';
import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_state.dart';
import 'package:domi_id/feature/presentation/widgets/address_text_field_widget.dart';
import 'package:domi_id/feature/presentation/widgets/head_row_widget.dart';
import 'package:domi_id/feature/presentation/widgets/location_suggestions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClaimAddressPage extends StatefulWidget {
  final Function(String, double, int, LatLng) onLocationSelected;
  final PageController pageController;

  const ClaimAddressPage({
    super.key,
    required this.onLocationSelected,
    required this.pageController,
  });

  @override
  _ClaimAddressPageState createState() => _ClaimAddressPageState();
}

class _ClaimAddressPageState extends State<ClaimAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final ValueNotifier<String> _address = ValueNotifier<String>('');

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderRow(currentPage: 0, pageController: widget.pageController),
            SizedBox(height: 8.h),
            Text(
              context.l10n.claimYourDomiId,
              style: context.theme.fonts.headerLarger.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              context.l10n.openMails,
              style: context.theme.fonts.bodyMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: context.theme.colors.textTertiary,
              ),
            ),
            SizedBox(height: 24.h),
            AddressTextField(
              controller: _addressController,
              onChanged: (value) {
                context.read<ClaimAddressCubit>().loadLocations(context);
                _address.value = value;
              },
            ),
            LocationSuggestions(
              addressNotifier: _address,
              onLocationSelected: widget.onLocationSelected,
            ),
            _address.value.isNotEmpty
                ? const SizedBox.shrink()
                : SizedBox(height: 32.h),
            ValueListenableBuilder(
              valueListenable: _address,
              builder: (context, value, child) {
                return BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
                    builder: (context, state) {
                  if (value.isNotEmpty) return const SizedBox.shrink();
                  return FilledButtonComponent(
                    active: true,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: context.l10n.claimAddress,
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
