// repositories/location_repository.dart
import 'package:domi_id/feature/data/models/location_model.dart';
import 'package:domi_id/feature/domain/repositories/location_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockLocationRepository extends LocationRepository {
  @override
  Future<List<LocationModel>> getLocations() async {
    return [
      LocationModel(
        name: 'Mall of Miami',
        address: '1451 N Miami Ave, Miami, Florida',
        coordinates: const LatLng(25.7907, -80.1980),
        price: 450.0,
        estimatedValue: 40000000,
      ),
      LocationModel(
        name: 'Orlando Premium Outlets',
        address: '8200 Vineland Ave, Orlando, Florida',
        coordinates: const LatLng(28.3843, -81.4962),
        price: 500.0,
        estimatedValue: 50000000,
      ),
      LocationModel(
        name: 'The Florida Mall',
        address: '8001 S Orange Blossom Trail, Orlando, Florida',
        coordinates: const LatLng(28.4489, -81.3959),
        price: 550.0,
        estimatedValue: 60000000,
      ),
      LocationModel(
        name: 'Sawgrass Mills',
        address: '12801 W Sunrise Blvd, Sunrise, Florida',
        coordinates: const LatLng(26.1503, -80.3249),
        price: 600.0,
        estimatedValue: 70000000,
      ),
      LocationModel(
        name: 'Westfield Sarasota Square',
        address: '8201 S Tamiami Trail, Sarasota, Florida',
        coordinates: const LatLng(27.2352, -82.4918),
        price: 300.0,
        estimatedValue: 30000000,
      ),
      LocationModel(
        name: 'Aventura Mall',
        address: '19501 Biscayne Blvd, Aventura, Florida',
        coordinates: const LatLng(25.9576, -80.1429),
        price: 700.0,
        estimatedValue: 80000000,
      ),
      LocationModel(
        name: 'International Plaza and Bay Street',
        address: '2223 N Westshore Blvd, Tampa, Florida',
        coordinates: const LatLng(27.9615, -82.5226),
        price: 650.0,
        estimatedValue: 70000000,
      ),
      LocationModel(
        name: 'St. Johns Town Center',
        address: '4663 River City Dr, Jacksonville, Florida',
        coordinates: const LatLng(30.2628, -81.5261),
        price: 480.0,
        estimatedValue: 45000000,
      ),
      LocationModel(
        name: 'The Gardens Mall',
        address: '3101 PGA Boulevard, Palm Beach Gardens, Florida',
        coordinates: const LatLng(26.8451, -80.0880),
        price: 520.0,
        estimatedValue: 55000000,
      ),
      LocationModel(
        name: 'The Mall at Millenia',
        address: '4200 Conroy Rd, Orlando, Florida',
        coordinates: const LatLng(28.4889, -81.4315),
        price: 600.0,
        estimatedValue: 60000000,
      ),
    ];
  }
}
