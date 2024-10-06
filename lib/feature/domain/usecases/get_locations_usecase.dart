import '../../data/models/location_model.dart';
import '../repositories/location_repository.dart';

class GetLocationsUseCase {
  final LocationRepository repository;

  GetLocationsUseCase(this.repository);

  Future<List<LocationModel>> call() async {
    return await repository.getLocations();
  }
}
