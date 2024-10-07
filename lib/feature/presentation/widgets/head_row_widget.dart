import 'package:domi_id/core/component/icon_components.dart';
import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/feature/presentation/bloc/claim_address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HeaderRow extends StatelessWidget {
  final int currentPage;
  final PageController pageController;

  const HeaderRow(
      {super.key, required this.currentPage, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(IconsComponents.arrowUp),
          onPressed: () {
            if (currentPage > 0) {
              pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            context.read<ClaimAddressCubit>().clearSelectedLocation();
          },
        ),
        Text(
          "${currentPage + 1}/2",
          style: context.theme.fonts.bodyMedium.copyWith(
            color: context.theme.colors.activeButton,
          ),
        ),
      ],
    );
  }
}
