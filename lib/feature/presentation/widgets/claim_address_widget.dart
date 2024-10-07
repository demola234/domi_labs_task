import 'package:domi_id/core/component/filled_button.dart';
import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/core/utils/heptic_manager/heptic_manager.dart';
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
  final ValueNotifier<bool> _showSuggestions = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _buttonVisible = ValueNotifier<bool>(false);
  final ValueNotifier<double> _containerHeight = ValueNotifier<double>(250);

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
            // Address Text Field
            AddressTextField(
              controller: _addressController,
              onChanged: (value) {
                context.read<ClaimAddressCubit>().loadLocations();
                _address.value = value;
                // Show suggestions and hide button when typing starts
                _showSuggestions.value = value.isNotEmpty;
                _buttonVisible.value = false;
                // Adjust the container size when typing
                _containerHeight.value = value.isNotEmpty ? 400.h : 250.h;
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _showSuggestions,
              builder: (context, showSuggestions, child) {
                return showSuggestions
                    ? LocationSuggestions(
                        addressNotifier: _address,
                        onLocationSelected:
                            (location, price, estimatedValue, coordinates) {
                          HapticManager.lightImpact();
                          // When a location is selected, hide suggestions
                          _showSuggestions.value = false;
                          _buttonVisible.value = true;
                          // Update the address field with the selected location
                          _addressController.text = location;
                          _address.value = location;
                          // Reduce container height
                          _containerHeight.value = 250.h;
                          // Call the callback for selected location
                          widget.onLocationSelected(
                              location, price, estimatedValue, coordinates);
                        },
                      )
                    : const SizedBox.shrink();
              },
            ),
            SizedBox(height: 32.h),
            // Button will appear only after location is selected
            BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
              builder: (context, state) {
                return state.maybeWhen(
                    loaded: (
                      selectedLocation,
                    ) =>
                        const SizedBox.shrink(),
                    orElse: () => FilledButtonComponent(
                          active: state.maybeWhen(
                            orElse: () => false,
                            selectedLocation: (selectedLocation, selectedPrice,
                                    estimatedPrice, markers) =>
                                true,
                          ),
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            HapticManager.selectionClick();
                            widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: context.l10n.claimAddress,
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
