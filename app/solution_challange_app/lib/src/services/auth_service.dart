import 'package:solution_challange_app/src/services/storage_service.dart';

class AuthService {
  Future<bool> isLoggedIn() async {
    String res = await SecureStorageService().readSecureData("token");
    if (res == '') {
      return false;
    }
    return true;
  }
}
