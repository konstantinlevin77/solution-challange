import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/auth_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

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

  Future<bool> loginUser(String username, String password) async {
    final Map<String, String> credentials = {
      "username": username,
      "password": password,
    };

    String credentialsJSON = jsonEncode(credentials);

    final response = await http.post(Uri.parse('$baseUrl/auth/loginUser'),
        body: credentialsJSON);

    if (response.statusCode == 200) {
      String id;
      String userType;
      String jwtToken = jsonDecode(response.body)["token"];

      Map<String, dynamic> decodedToken = Jwt.parseJwt(jwtToken);

      id = decodedToken["id"];
      userType = decodedToken["user_type"];

      SecureStorageService().writeSecureData("token", jwtToken);
      SecureStorageService().writeSecureData("id", id);
      SecureStorageService().writeSecureData("user_type", userType);

      AuthService().login();

      return true;
    }
    return false;
  }

  Future logoutUser() async {
    SecureStorageService().deleteSecureData("token");
    SecureStorageService().deleteSecureData("id");
    SecureStorageService().deleteSecureData("user_type");

    AuthService().logout();
  }
}
