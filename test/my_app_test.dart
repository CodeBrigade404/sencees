import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sencees/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sencees/src/features/authentication/presentation/views/login_view.dart';
import 'package:sencees/src/features/user_onboard/presentation/views/onboarding_view.dart';

void main() {
  testWidgets('MyApp shows LoginView when onboarding is true',
      (WidgetTester tester) async {
    // Create a fake SharedPreferences instance with onboarding set to true
    SharedPreferences.setMockInitialValues({'onboarding': true});

    // Ensure the WidgetsFlutterBinding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Build the MyApp widget
    await tester.pumpWidget(const MyApp(onboarding: true));

    // Verify that LoginView is displayed
    expect(find.byType(LoginView), findsOneWidget);
    expect(find.byType(OnboardingView), findsNothing);
  });

  testWidgets('MyApp shows OnboardingView when onboarding is false',
      (WidgetTester tester) async {
    // Create a fake SharedPreferences instance with onboarding set to false
    SharedPreferences.setMockInitialValues({'onboarding': false});

    // Ensure the WidgetsFlutterBinding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Build the MyApp widget
    await tester.pumpWidget(const MyApp(onboarding: false));

    // Verify that OnboardingView is displayed
    expect(find.byType(OnboardingView), findsOneWidget);
    expect(find.byType(LoginView), findsNothing);
  });
}
