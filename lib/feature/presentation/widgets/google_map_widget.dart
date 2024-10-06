import 'dart:async';

import 'package:domi_id/core/utils/map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final Completer<GoogleMapController> mapController;
  final List<Marker> markers;

  const GoogleMapWidget({
    super.key,
    required this.mapController,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(27.9506, -82.4572),
          zoom: 14.0,
        ),
        mapType: MapType.normal,
        myLocationEnabled: false,
        mapToolbarEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
          grayModeMapFeature(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}
