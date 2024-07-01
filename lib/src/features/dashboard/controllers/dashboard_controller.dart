import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sencees/src/features/dashboard/models/user_model.dart';
import 'package:sencees/src/features/dashboard/repository/dashboard_repo.dart';

final dashboardControllerProvider = Provider((ref) {
  final dashBoardRepo = ref.watch(dashboardRepoProvider);
  return DashboardController(dashBoardRepo: dashBoardRepo);
});

class DashboardController {
  final DashboardRepo _dashBoardRepo;

  DashboardController({required DashboardRepo dashBoardRepo})
      : _dashBoardRepo = dashBoardRepo;

  Future<List<User>> getUsers() async {
    final response = await _dashBoardRepo.getUsers();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<User> users = [];
      if (data['users'] is List) {
        final usersJson = data['users'] as List;
        for (dynamic userJson in usersJson) {
          users.add(User.fromJson(userJson));
        }
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
