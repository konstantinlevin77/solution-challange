import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:solution_challange_app/src/models/user.dart';

class UserService {
  final String baseUrl;
  UserService({required this.baseUrl});

  Future<User> getUserById(String id) async {
    // TODO: Implement storage service to get token from local storage.
    const String jwtToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBXMHZVZGRBd2Z1d3ZTWGtYSnY3IiwidXNlcl90eXBlIjoidXNlciJ9.3D--65nMNtJXUAi3eGQ952gkNIVPApKv3dlmxXKRrhI";

    final response = await http
        .get(Uri.parse('$baseUrl/protected/users/getById/$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken'
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      return User.fromJson(userData);
    } else {
      throw Exception(
          "Failed to find the user with given id, or any problem occured");
    }
  }
}
