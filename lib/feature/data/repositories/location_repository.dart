// repositories/location_repository.dart
import 'package:domi_id/feature/data/models/location_model.dart';
import 'package:domi_id/feature/domain/repositories/location_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockLocationRepository extends LocationRepository {
  @override
  Future<List<LocationModel>> getLocations() async {
    return [
      LocationModel(
        name: '3A street',
        address: '3A street, Tampa, Florida',
        coordinates: const LatLng(27.9506, -82.4572),
        price: 150.0,
        estimatedValue: 20000,
      ),
      LocationModel(
        name: '2B street',
        address: '2B street, Tampa, Florida',
        coordinates: const LatLng(27.9510, -82.4580),
        price: 200.0,
        estimatedValue: 29600000,
      ),
      LocationModel(
        name: '1C street',
        address: '1C street, Tampa, Florida',
        coordinates: const LatLng(27.9520, -82.4590),
        price: 250.0,
        estimatedValue: 31600000,
      ),
    ];
  }
}
