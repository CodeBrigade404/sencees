import 'package:flutter/material.dart';
import 'package:sencees/src/core/configs/themes.dart';
import 'package:sencees/src/features/authentication/presentation/views/login_view.dart';
import 'package:sencees/src/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:sencees/src/features/user_onboard/presentation/views/onboarding_view.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  final bool onboarding;
  final String? accessToken;

  const MyApp({
    super.key,
    this.onboarding = false,
    this.accessToken,
  });

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sencees',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: _getInitialView(),
      ),
    );
  }

  Widget _getInitialView() {
    if (!onboarding) {
      return const OnboardingView();
    } else if (accessToken != null && accessToken!.isNotEmpty) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  }
}
