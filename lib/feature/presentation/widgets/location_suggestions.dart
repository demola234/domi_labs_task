import 'package:domi_id/core/utils/sized_box_extension.dart';
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
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (locations) {
                if (locations.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child:
                        Text('No locations found', textAlign: TextAlign.center),
                  );
                }

                return SizedBox(
                  height: context.screenHeight(0.5),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: locations.length,
                    padding: const EdgeInsets.only(top: 16),
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onLocationSelected(
                            location.address,
                            location.price,
                            location.estimatedValue,
                            location.coordinates,
                          );
                        },
                        child: LocationTile(
                          name: location.name,
                          address: location.address,
                        ),
                      );
                    },
                  ),
                );
              },
              error: (message) => Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Error: $message',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red)),
              ),
            );
          },
        );
      },
    );
  }
}
