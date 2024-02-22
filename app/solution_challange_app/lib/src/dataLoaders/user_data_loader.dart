import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/cache_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

class UserDataLoader {
  static Future<User> getUserData() async {
    final cacheService =
        CacheService(secureStorageService: SecureStorageService());
    if (await cacheService.isUserCacheValid()) {
      return cacheService.getUserFromCache();
    } else {
      final user = await fetchDataFromDatabase();
      await cacheService.cacheUser(user);
      return user;
    }
  }

  static Future<User> fetchDataFromDatabase() async {
    String userId = await SecureStorageService().readSecureData("id");
    var fetchedUserData = UserService(baseUrl: BASE_URL).getUserById(userId);
    return fetchedUserData;
  }
}