import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final dashboardRepoProvider = Provider((ref) => DashboardRepo());

class DashboardRepo {
  Future<http.Response> getUsers() async {
    final url = Uri.parse("http://dummyjson.com/users");
    final response = await http.get(url);
    return response;
  }
}
