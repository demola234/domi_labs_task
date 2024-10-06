import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:domi_id/feature/domain/usecases/get_locations_usecase.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_state.dart';
import 'package:domi_id/feature/presentation/widgets/custom_marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClaimAddressCubit extends Cubit<ClaimAddressState> {
  final GetLocationsUseCase getLocationsUseCase;

  ClaimAddressCubit(this.getLocationsUseCase) : super(ClaimAddressState());

  // Load locations from the use case without creating markers initially
  Future<void> loadLocations(BuildContext context) async {
    emit(state.copyWith(loading: true));

    // Fetch the locations using the use case
    final locations = await getLocationsUseCase();

    // Emit the state with loaded locations, no markers yet
    emit(state.copyWith(locations: locations, loading: false));
  }

  // Select a location and display a single marker
  Future<void> selectLocation(BuildContext context, String location, double price, int estimatedValue, LatLng coordinates) async {
    emit(state.copyWith(
      selectedLocation: location,
      selectedPrice: price,
      estimatedPrice: estimatedValue,
      loading: true, // Show loading while marker is being created
    ));

    // Clear any previous markers
    List<Marker> markers = [];

    // Convert the selected location into a marker
    final markerWidget = CustomMarkerWidget(address: location, price: price);
    final markerIcon = await _widgetToBitmap(markerWidget, const Size(180, 200), context);

    Marker marker = Marker(
      markerId: MarkerId(location),
      position: coordinates,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    markers.add(marker);

    // Emit the state with the single marker
    emit(state.copyWith(
      markers: markers,
      loading: false, // Stop loading after marker is created
    ));
  }

  // Helper method to convert a widget to a bitmap image for the marker icon
  Future<Uint8List> _widgetToBitmap(
      Widget widget, Size size, BuildContext context) async {
    final GlobalKey repaintKey = GlobalKey();

    final RenderRepaintBoundary boundary =
        await _getRepaintBoundary(widget, repaintKey, size, context);
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      return byteData.buffer.asUint8List();
    } else {
      throw Exception('Failed to convert widget to image');
    }
  }

  Future<RenderRepaintBoundary> _getRepaintBoundary(
      Widget widget, GlobalKey key, Size size, BuildContext context) async {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: RepaintBoundary(
            key: key,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: widget,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    await Future.delayed(const Duration(milliseconds: 100));

    final RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    entry.remove();
    return boundary;
  }
}
