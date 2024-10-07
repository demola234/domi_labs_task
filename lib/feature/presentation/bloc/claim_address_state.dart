import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/location_model.dart';

part 'claim_address_state.freezed.dart';

@freezed
class ClaimAddressState with _$ClaimAddressState {
  const factory ClaimAddressState.initial() = _Initial;
  const factory ClaimAddressState.loading() = _Loading;
  const factory ClaimAddressState.loaded({
    required List<LocationModel> locations,
  }) = _Loaded;
  const factory ClaimAddressState.selectedLocation({
    String? selectedLocation,
    double? selectedPrice,
    int? estimatedPrice,
    required List<Marker> markers,
  }) = _SelectedLocation;
  const factory ClaimAddressState.error(String message) = _Error;
}
