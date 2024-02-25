import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';
import 'package:solution_challange_app/src/services/cache_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

class BusinessAccountDataLoader {
  static Future<BusinessAccount> getBusinessAccountData() async {
    final cacheService =
        CacheService(secureStorageService: SecureStorageService());
    if (await cacheService.isBusinessAccountCacheValid()) {
      return cacheService.getBusinessAccountFromCache();
    } else {
      final user = await fetchDataFromDatabase();
      await cacheService.cacheBusinessAccount(user);
      return user;
    }
  }

  static Future<BusinessAccount> fetchDataFromDatabase() async {
    String userId = await SecureStorageService().readSecureData("id");
    var fetchedUserData = BusinessAccountService(baseUrl: BASE_URL).getBusinessAccountById(userId);
    return fetchedUserData;
  }
}