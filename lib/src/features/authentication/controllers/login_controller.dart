import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../repository/login_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthController(authRepo: authRepo);
});

class AuthController {
  final LoginRepo _authRepo;

  AuthController({required LoginRepo authRepo}) : _authRepo = authRepo;

  Future<Login?> signIn(String username, String password) async {
    final response = await _authRepo.signIn(username, password);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final login = Login.fromJson(data);

      // Save access token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', login.accessToken ?? '');

      return login;
    } else {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['error'];
      throw Exception(errorMessage);
    }
  }
}
