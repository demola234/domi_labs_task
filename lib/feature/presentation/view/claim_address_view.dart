import 'dart:async';
import 'dart:math';

import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/core/design_system/theme_extension/theme_detection.dart';
import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/core/utils/sized_box_extension.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_state.dart';
import 'package:domi_id/feature/presentation/widgets/google_map_widget.dart';
import 'package:domi_id/feature/presentation/widgets/page_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClaimAddressScreen extends StatefulWidget {
  const ClaimAddressScreen({super.key});

  @override
  _ClaimAddressScreenState createState() => _ClaimAddressScreenState();
}

class _ClaimAddressScreenState extends State<ClaimAddressScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  late PageController _pageController;
  CameraPosition? _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> pageHeight =
        ValueNotifier<double>(context.screenHeight(0.4));
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
              builder: (context, state) {
                return GoogleMapWidget(
                  mapController: _mapController,
                  markers: state.maybeWhen(
                    orElse: () => [],
                    selectedLocation: (selectedLocation, selectedPrice,
                            estimatedPrice, markers) =>
                        markers,
                  ),
                );
              },
            ),
            Positioned(
                top: 50,
                right: 40,
                child: Container(
                  height: 40.sp,
                  width: 40.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: context.theme.colors.textWhite,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      _showLanguageDropdown(context);
                    },
                  ),
                )),
            Positioned(
              bottom: 30.sp,
              left: 20.sp,
              right: 20.sp,
              child: ValueListenableBuilder<double>(
                valueListenable: pageHeight,
                builder: (context, height, child) =>
                    ValueListenableBuilder<int>(
                  valueListenable: _currentPage,
                  builder: (context, page, child) =>
                      BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
                    builder: (context, state) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: state.maybeWhen(
                          orElse: () => page == 0
                              ? context.screenHeight(0.4)
                              : context.screenHeight(0.45),
                          loaded: (location) => context.screenHeight(0.6),
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.colors.textWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.r),
                          ),
                        ),
                        child: child,
                      );
                    },
                  ),
                  child: BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
                    builder: (context, state) {
                      return PageViewWidget(
                        currentPage: _currentPage,
                        pageHeight: pageHeight,
                        pageController: _pageController,
                        onClaimLocationSelected:
                            (location, price, estimatedValue, coordinates) {
                          context.read<ClaimAddressCubit>().selectLocation(
                              context,
                              location,
                              price,
                              estimatedValue,
                              coordinates);
                          _goToLocation(coordinates);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ThemeCubit, ThemeModeEnum>(
          builder: (context, themeState) {
            return BlocBuilder<LocalizationCubit, Localization>(
              builder: (context, state) {
                return AlertDialog(
                  title: Text(
                    'Settings',
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  backgroundColor: context.theme.colors.surface,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<ThemeModeEnum>(
                        value: themeState,
                        dropdownColor: context.theme.colors.surfaceCard,
                        onChanged: (ThemeModeEnum? newValue) {
                          if (newValue != null) {
                            context.read<ThemeCubit>().setTheme(newValue);
                          }
                          Navigator.of(context).pop();
                        },
                        items: ThemeModeEnum.values
                            .map<DropdownMenuItem<ThemeModeEnum>>(
                                (ThemeModeEnum value) {
                          return DropdownMenuItem<ThemeModeEnum>(
                            value: value,
                            child: Text(
                              value.name,
                              style: context.theme.fonts.bodyMedium.copyWith(
                                color: context.theme.colors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<Localization>(
                        value: state,
                        dropdownColor: context.theme.colors.surfaceCard,
                        onChanged: (Localization? newValue) {
                          if (newValue != null) {
                            context
                                .read<LocalizationCubit>()
                                .changeLocalization(newValue);
                          }
                          Navigator.of(context).pop();
                        },
                        items: Localization.values
                            .map<DropdownMenuItem<Localization>>(
                                (Localization value) {
                          return DropdownMenuItem<Localization>(
                            value: value,
                            child: Text(
                              value.name,
                              style: context.theme.fonts.bodyMedium.copyWith(
                                color: context.theme.colors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Close the dialog without changes
                      },
                      child: Text(
                        'Cancel',
                        style: context.theme.fonts.bodyMedium.copyWith(
                          color: context.theme.colors.textHighlightBlue,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _goToLocation(LatLng coordinates) async {
    final GoogleMapController controller = await _mapController.future;

    if (_currentCameraPosition != null) {
      double distance = _calculateDistance(
        _currentCameraPosition!.target.latitude,
        _currentCameraPosition!.target.longitude,
        coordinates.latitude,
        coordinates.longitude,
      );

      if (distance < 1000) {
        controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: coordinates, zoom: 17, tilt: 30),
        ));
      } else {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: coordinates, zoom: 17, tilt: 30, bearing: 180),
        ));
      }
    } else {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: coordinates, zoom: 17, tilt: 30, bearing: 180),
      ));
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
