import 'package:bloc_test/bloc_test.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_state.dart';
import 'package:domi_id/feature/presentation/view/claim_address_view.dart';
import 'package:domi_id/feature/presentation/widgets/google_map_widget.dart';
import 'package:domi_id/feature/presentation/widgets/page_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';

// Mocking the ClaimAddressCubit
class MockClaimAddressCubit extends MockCubit<ClaimAddressState>
    implements ClaimAddressCubit {}

// Mocking GoogleMapController
class MockGoogleMapController extends Mock implements GoogleMapController {}

void main() {
  late MockClaimAddressCubit mockClaimAddressCubit;
  late MockGoogleMapController mockGoogleMapController;

  setUp(() {
    mockClaimAddressCubit = MockClaimAddressCubit();
    mockGoogleMapController = MockGoogleMapController();
  });

  group('ClaimAddressScreen Widget Test', () {
    testWidgets(
        'renders GoogleMapWidget and PageViewWidget, handles location selection',
        (tester) async {
      // Define a sample location marker
      const LatLng sampleCoordinates =
          LatLng(37.42796133580664, -122.085749655962);
      final List<Marker> sampleMarkers = [
        const Marker(
            markerId: MarkerId('sample_marker'), position: sampleCoordinates),
      ];

      // Mock the state where location is selected
      when(() => mockClaimAddressCubit.state).thenReturn(
        ClaimAddressState.selectedLocation(
          selectedLocation: 'Sample Location',
          selectedPrice: 1000,
          estimatedPrice: 1500,
          markers: sampleMarkers,
        ),
      );

      // Build the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ClaimAddressCubit>(
            create: (_) => mockClaimAddressCubit,
            child: const ClaimAddressScreen(),
          ),
        ),
      );

      // Verify the Google Map is rendered with the correct markers
      expect(find.byType(GoogleMapWidget), findsOneWidget);

      // Verify PageViewWidget is displayed
      expect(find.byType(PageViewWidget), findsOneWidget);

      // Wait for animations to settle
      await tester.pumpAndSettle();

      // Interact with the PageView
      await tester.tap(find.byType(PageViewWidget));
      await tester.pumpAndSettle();

      // Verify the cubit was called when a location was selected
      verify(() => mockClaimAddressCubit.selectLocation(
            any(),
            'Sample Location',
            1000,
            1500,
            sampleCoordinates,
          )).called(1);

      // Check that the AnimatedContainer changes height on state change
      expect(find.byType(AnimatedContainer), findsOneWidget);

      // Interact with the height changes in the AnimatedContainer
      await tester.tap(find.byType(AnimatedContainer));
      await tester.pumpAndSettle();
    });
  });
}
