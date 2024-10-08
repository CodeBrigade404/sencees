import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sencees/src/core/constants/app_urls.dart';

final authRepositoryProvider = Provider((ref) => LoginRepo());

class LoginRepo {
  Future<http.Response> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('${BASE_URL}sign_in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    return response;
  }
}
