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

  Future<List<Menu>> getMenusByBusinessId(String businessId) async {
    String jwtToken = await SecureStorageService().readSecureData("token");

    final response = await http.get(
      Uri.parse("$baseUrl/protected/menus/getAllByBusinessId/$businessId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken"
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Menu> menuList = jsonList.map((e) => Menu.fromJson(e)).toList();
      return menuList;
    } else {
      throw Exception("Failed to find menus with given business id");
    }
  }
}
