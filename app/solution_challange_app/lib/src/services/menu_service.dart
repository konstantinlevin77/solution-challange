import 'dart:convert';

import 'package:solution_challange_app/src/models/menu.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:http/http.dart' as http;

class MenuService {
  String baseUrl;

  MenuService({required this.baseUrl});

  Future<bool> addMenu(Menu menu) async {
    String jwtToken = await SecureStorageService().readSecureData("token");
    final menuJSON = jsonEncode(menu.toJson());

    final result = await http.post(Uri.parse("$baseUrl/protected/menus/add"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: menuJSON);

    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
