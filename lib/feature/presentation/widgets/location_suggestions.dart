import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_state.dart';
import 'package:domi_id/feature/presentation/widgets/location_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSuggestions extends StatelessWidget {
  final ValueNotifier<String> addressNotifier;
  final Function(String, double, int, LatLng) onLocationSelected;

  const LocationSuggestions({
    super.key,
    required this.addressNotifier,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: addressNotifier,
      builder: (context, value, child) {
        if (value.isEmpty) return const SizedBox.shrink();
        return BlocBuilder<ClaimAddressCubit, ClaimAddressState>(
          builder: (context, state) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.locations.length,
              padding: const EdgeInsets.only(top: 16),
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onLocationSelected(
                    state.locations[index].address,
                    state.locations[index].price,
                    state.locations[index].estimatedValue,
                    state.locations[index].coordinates,
                  );
                },
                child: LocationTile(
                  name: state.locations[index].name,
                  address: state.locations[index].address,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
