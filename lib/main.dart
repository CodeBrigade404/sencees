import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  final accessToken = prefs.getString("accessToken");

  runApp(ProviderScope(
      child: MyApp(
    onboarding: onboarding,
    accessToken: accessToken,
  )));
}
