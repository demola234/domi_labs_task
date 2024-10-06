import 'package:domi_id/feature/data/repositories/location_repository.dart';
import 'package:domi_id/feature/domain/repositories/location_repository.dart';
import 'package:domi_id/feature/domain/usecases/get_locations_usecase.dart';
import 'package:get_it/get_it.dart';

final appInjector = GetIt.I;

Future<void> injector() async {
  appInjector

    // Repository
    ..registerLazySingleton<LocationRepository>(() => MockLocationRepository())

    // UseCase
    ..registerLazySingleton<GetLocationsUseCase>(
      () => GetLocationsUseCase(appInjector()),
    );
}
