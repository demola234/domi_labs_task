import 'package:domi_id/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:domi_id/core/localization/generated/strings.dart';
import 'package:domi_id/core/localization/localization_detection.dart';
import 'package:domi_id/feature/presentation/view/claim_address_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return BlocBuilder<LocalizationCubit, Localization>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              themeMode: ThemeMode.light,
              themeAnimationCurve: Curves.easeInCubic,
              locale: Locale(state.name),
              supportedLocales: const [
                Locale('en', ''),
                Locale('es', ''),
                Locale('fr', ''),
                Locale('nl', ''),
                Locale('zh', ''),
              ],
              localizationsDelegates: const [
                Strings.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              themeAnimationDuration: const Duration(seconds: 1),
              home: const ClaimAddressScreen(),
            );
          },
        );
      },
    );
  }
}
