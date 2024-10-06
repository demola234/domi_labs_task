import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/location_model.dart';

class ClaimAddressState {
  final List<LocationModel> locations;
  final String? selectedLocation;
  final double? selectedPrice;
  final int? estimatedPrice;
  final bool loading;
  final List<Marker> markers;

  ClaimAddressState({
    this.locations = const [],
    this.selectedLocation,
    this.selectedPrice,
    this.estimatedPrice,
    this.loading = false,
    this.markers = const [],
  });

  ClaimAddressState copyWith({
    List<LocationModel>? locations,
    String? selectedLocation,
    double? selectedPrice,
    int? estimatedPrice,
    bool? loading,
    List<Marker>? markers, // Add marker to copyWith
  }) {
    return ClaimAddressState(
      locations: locations ?? this.locations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedPrice: selectedPrice ?? this.selectedPrice,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      loading: loading ?? this.loading,
      markers: markers ?? this.markers, // Update markers if provided
    );
  }
}
