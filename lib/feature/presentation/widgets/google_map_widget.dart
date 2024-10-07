import 'dart:async';

import 'package:domi_id/core/design_system/theme_extension/theme_detection.dart';
import 'package:domi_id/core/utils/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> mapController;
  final List<Marker> markers;

  const GoogleMapWidget({
    super.key,
    required this.mapController,
    required this.markers,
  });

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? _controller;

  // Function to apply the map style based on theme
  void _applyMapStyle(ThemeModeEnum theme) {
    if (_controller != null) {
      bool isDarkMode = theme.name == 'Dark';
      grayModeMapFeature(_controller!, isDarkMode); // Apply the correct style
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ThemeCubit, ThemeModeEnum>(
          builder: (context, state) {
            _applyMapStyle(state);

            return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(27.9506, -82.4572),
                zoom: 14.0,
              ),
              mapType: MapType.normal,
              myLocationEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                widget.mapController.complete(controller);
                _controller = controller;

                // Set initial map style based on the theme
                _applyMapStyle(state);
              },
              markers: Set<Marker>.of(widget.markers),
            );
          },
        ),
        // Example of how to use Positioned in a Stack properly
        Positioned(
          left: 10,
          bottom: 10,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: const Text('Map Information'),
          ),
        ),
      ],
    );
  }
}
