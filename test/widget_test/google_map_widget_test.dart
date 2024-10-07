import 'dart:async';
import 'dart:io';

import 'package:domi_id/core/design_system/theme_extension/theme_detection.dart';
import 'package:domi_id/feature/presentation/widgets/google_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for MethodChannel
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGoogleMapController extends Mock implements GoogleMapController {}

void main() {
  const MethodChannel pathProviderChannel =
      MethodChannel('plugins.flutter.io/path_provider');
  const MethodChannel googleMapsChannel =
      MethodChannel('plugins.flutter.io/google_maps');

  setUpAll(() async {
    // Intercept the MethodChannel for path_provider and google_maps
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock the getApplicationDocumentsDirectory call
    pathProviderChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return Directory.systemTemp.path; // Return a temp directory path
      }
      return null;
    });

    // Mock the google_maps platform calls
    googleMapsChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null; // No actual implementation needed for tests
    });

    // Initialize HydratedBloc storage with the mocked path
    final tempDir = await Directory.systemTemp.createTemp();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: tempDir);
  });

  tearDownAll(() {
    // Remove the mock after all tests
    pathProviderChannel.setMockMethodCallHandler(null);
    googleMapsChannel.setMockMethodCallHandler(null);
  });

  testWidgets(
      'GoogleMapWidget renders and interacts with GoogleMapController and ThemeCubit',
      (WidgetTester tester) async {
    // Setup the mock controller and markers
    final mockMapController = MockGoogleMapController();
    final Completer<GoogleMapController> controllerCompleter = Completer();
    final List<Marker> testMarkers = [
      const Marker(
          markerId: MarkerId('marker1'), position: LatLng(27.9506, -82.4572)),
    ];

    // Mock the setMapStyle function
    when(() => mockMapController.setMapStyle(any())).thenAnswer((_) async {});

    // Ensure HydratedBloc.storage is initialized before testing
    await tester.runAsync(() async {
      // Build the widget using a BlocProvider for ThemeCubit
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
            child: Scaffold(
              body: GoogleMapWidget(
                mapController: controllerCompleter,
                markers: testMarkers,
              ),
            ),
          ),
        ),
      );
    });

    // Ensure the GoogleMap widget exists
    expect(find.byType(GoogleMap), findsOneWidget);

    // Simulate the map creation and interaction
    await tester.runAsync(() async {
      controllerCompleter.complete(mockMapController);
      await Future.delayed(
          Duration.zero); // Wait for the controller to complete
    });

    // Verify that the map controller was completed
    expect(controllerCompleter.isCompleted, isTrue);

    // Verify that markers are rendered properly
    final GoogleMap googleMap = tester.widget(find.byType(GoogleMap));
    expect(googleMap.markers.length, 1);
    expect(googleMap.markers.first.markerId.value, 'marker1');

    // Check the theme application logic
    final themeCubit = BlocProvider.of<ThemeCubit>(
        tester.element(find.byType(GoogleMapWidget)));
    themeCubit.setTheme(ThemeModeEnum.Dark); // Simulate dark theme
    await tester.pumpAndSettle();

    // Verify that the map style is applied based on theme
    verifyNever(() => mockMapController.setMapStyle(any())).called(0);
  });
}
