import 'dart:async';
import 'dart:math';

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
  final ValueNotifier<double> _pageHeight = ValueNotifier<double>(400);
  late PageController _pageController;
  CameraPosition? _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            // Use BlocBuilder to build the GoogleMapWidget with markers
            BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
              builder: (context, state) {
                return GoogleMapWidget(
                  mapController: _mapController,
                  markers: state.markers,
                );
              },
            ),
            Positioned(
              bottom: 30.sp,
              left: 20.sp,
              right: 20.sp,
              child: ValueListenableBuilder<double>(
                valueListenable: _pageHeight,
                builder: (context, height, child) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.r),
                    ),
                  ),
                  child: child,
                ),
                child: BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
                  builder: (context, state) {
                    return PageViewWidget(
                      currentPage: _currentPage,
                      pageHeight: _pageHeight,
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
          ],
        ),
      ),
    );
  }

  Future<void> _goToLocation(LatLng coordinates) async {
    final GoogleMapController controller = await _mapController.future;

    // Use the stored current camera position for distance calculation
    if (_currentCameraPosition != null) {
      double distance = _calculateDistance(
        _currentCameraPosition!.target.latitude,
        _currentCameraPosition!.target.longitude,
        coordinates.latitude,
        coordinates.longitude,
      );

      // If the distance is less than a certain threshold, move the camera instead of animating
      if (distance < 1000) {
        controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: coordinates, zoom: 17, tilt: 30),
        ));
      } else {
        // Animate the camera for farther locations
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: coordinates, zoom: 17, tilt: 30, bearing: 180),
        ));
      }
    } else {
      // If no previous position is available, animate by default
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: coordinates, zoom: 17, tilt: 30, bearing: 180),
      ));
    }
  }

  // Calculate distance between two geographical points
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Math.PI / 180
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }
}
