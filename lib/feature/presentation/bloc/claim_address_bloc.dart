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

  ClaimAddressCubit(this.getLocationsUseCase)
      : super(const ClaimAddressState.initial());

  Future<void> loadLocations() async {
    emit(const ClaimAddressState.loading());

    try {
      final locations = await getLocationsUseCase();

      emit(ClaimAddressState.loaded(
        locations: locations,
      ));
    } catch (e) {
      emit(ClaimAddressState.error(e.toString()));
    }
  }

  void clearSelectedLocation() {
    emit(const ClaimAddressState.initial());
  }

  Future<void> selectLocation(BuildContext context, String selectedLocation,
      double price, int estimatedValue, LatLng coordinates) async {
    emit(const ClaimAddressState.loading());

    try {
      List<Marker> markers = [];

      final markerWidget =
          CustomMarkerWidget(address: selectedLocation, price: price);
      final markerIcon =
          await _widgetToBitmap(markerWidget, const Size(200, 200), context);

      Marker marker = Marker(
        markerId: MarkerId(selectedLocation),
        position: coordinates,
        icon: BitmapDescriptor.fromBytes(markerIcon),
      );

      markers.add(marker);

      emit(ClaimAddressState.selectedLocation(
        selectedLocation: selectedLocation,
        selectedPrice: price,
        estimatedPrice: estimatedValue,
        markers: markers,
      ));
    } catch (e) {
      emit(ClaimAddressState.error(e.toString()));
    }
  }

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
