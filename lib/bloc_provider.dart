import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/feature/domain/usecases/get_locations_usecase.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:domi_id/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/design_system/theme_extension/theme_detection.dart';

class AppProvider {
  static List<BlocProvider> getList() {
    return [
      BlocProvider<ThemeCubit>(
        create: (_) => ThemeCubit(),
      ),
      BlocProvider<LocalizationCubit>(
        create: (_) => LocalizationCubit(),
      ),
      BlocProvider<ClaimAddressCubit>(
        create: (_) => ClaimAddressCubit(appInjector<GetLocationsUseCase>()),
      ),
    ];
  }
}
