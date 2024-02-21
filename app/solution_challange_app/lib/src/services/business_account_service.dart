import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

// TODO: Better error handling is needed.

class BusinessAccountService {
  final String baseUrl;
  BusinessAccountService({required this.baseUrl});

  Future<BusinessAccount> getBusinessAccountById(String id) async {
    String jwtToken = await SecureStorageService().readSecureData("token");

    final response = await http.get(
        Uri.parse("$baseUrl/protected/businessAccounts/getById/$id"),
        headers: {
          'Content-Type': "application/json",
          'Authorization': 'Bearer $jwtToken'
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> businessAccountData =
          jsonDecode(response.body);
      return BusinessAccount.fromJson(businessAccountData);
    } else {
      throw Exception(
          "Failed to find the business account, or something went wrong");
    }
  }

  Future<bool> loginBusinessAccount(String username, String password) async {
    final Map<String, String> credentials = {
      "username": username,
      "password": password,
    };

    String credentialsJSON = jsonEncode(credentials);
    final response = await http.post(
        Uri.parse('$baseUrl/auth/loginBusinessAccount'),
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
      return true;
    }

    return false;
  }

  Future logoutBusinessAccount() async {
    SecureStorageService().deleteSecureData("token");
    SecureStorageService().deleteSecureData("id");
    SecureStorageService().deleteSecureData("user_type");

  }
}
