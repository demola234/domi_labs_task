import 'package:domi_id/feature/presentation/widgets/claim_address_widget.dart';
import 'package:domi_id/feature/presentation/widgets/earn_with_domi_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageViewWidget extends StatelessWidget {
  final ValueNotifier<int> currentPage;
  final ValueNotifier<double> pageHeight;
  final Function(String, double, int, LatLng) onClaimLocationSelected;
  final PageController pageController;

  const PageViewWidget({
    super.key,
    required this.currentPage,
    required this.pageHeight,
    required this.onClaimLocationSelected,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (int page) {
        currentPage.value = page;
      },
      children: [
        ClaimAddressPage(
          onLocationSelected: onClaimLocationSelected,
          pageController: pageController,
        ),
        EarnWithDomiIDPage(
          pageController: pageController,
        ),
      ],
    );
  }
}
