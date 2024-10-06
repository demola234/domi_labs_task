import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  final String name;
  final String address;
  final LatLng coordinates;
  final double price;
  final int estimatedValue;

  LocationModel({
    required this.name,
    required this.address,
    required this.coordinates,
    required this.price,
    required this.estimatedValue,
  });
}
