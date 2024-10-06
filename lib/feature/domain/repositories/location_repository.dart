import 'package:domi_id/feature/data/models/location_model.dart';

abstract class LocationRepository {
  Future<List<LocationModel>> getLocations();
}
