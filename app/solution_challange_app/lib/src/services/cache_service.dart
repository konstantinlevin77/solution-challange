import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

// I know, this isn't even close to be an effective caching mechanism, but time constraints led me to this.
class CacheService {
  SecureStorageService secureStorageService;

  CacheService({required this.secureStorageService});

  Future cacheUser(User user) async {
    await secureStorageService.writeSecureData("CACHE_user_cached", "true");
    await secureStorageService.writeSecureData("CACHE_user_id", user.id);
    await secureStorageService.writeSecureData(
        "CACHE_user_username", user.username);
    await secureStorageService.writeSecureData("CACHE_user_email", user.email);
    await secureStorageService.writeSecureData(
        "CACHE_user_password", user.password);
    await secureStorageService.writeSecureData(
        "CACHE_user_firstname", user.firstName);
    await secureStorageService.writeSecureData(
        "CACHE_user_lastname", user.lastName);
    await secureStorageService.writeSecureData(
        "CACHE_user_profilepicturepath", user.profilePicturePath);
    await secureStorageService.writeSecureData("CACHE_user_bio", user.bio);
    await secureStorageService.writeSecureData(
        "CACHE_user_instaprofilelink", user.instaProfileLink);

    double currentTime = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

    currentTime = currentTime + 60 * CACHE_EXPIRATION_MINUTES;

    await secureStorageService.writeSecureData(
        "CACHE_user_expiration", currentTime.toString());
  }

  Future<bool> isUserCacheValid() async {
    if (await secureStorageService.readSecureData("CACHE_user_cached") !=
        "true") {
      return false;
    }

    double expirationTime = double.parse(
        await secureStorageService.readSecureData("CACHE_user_expiration"));

    double currentTime = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

    return expirationTime > currentTime;
  }

  Future<User> getUserFromCache() async {
    String id = await secureStorageService.readSecureData("CACHE_user_id");
    String username =
        await secureStorageService.readSecureData("CACHE_user_username");
    String email =
        await secureStorageService.readSecureData("CACHE_user_email");
    String password =
        await secureStorageService.readSecureData("CACHE_user_password");
    String firstName =
        await secureStorageService.readSecureData("CACHE_user_firstname");
    String lastName =
        await secureStorageService.readSecureData("CACHE_user_lastname");
    String profilePicturePath = await secureStorageService
        .readSecureData("CACHE_user_profilepicturepath");
    String bio = await secureStorageService.readSecureData("CACHE_user_bio");
    String instaProfileLink = await secureStorageService
        .readSecureData("CACHE_user_instaprofilelink");

    User u = User(
        id: id,
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        profilePicturePath: profilePicturePath,
        instaProfileLink: instaProfileLink);

    return u;
  }

  Future clearUserCache() async {
    await secureStorageService.deleteSecureData("CACHE_user_cached");
    await secureStorageService.deleteSecureData("CACHE_user_id");
    await secureStorageService.deleteSecureData("CACHE_user_username");
    await secureStorageService.deleteSecureData("CACHE_user_email");
    await secureStorageService.deleteSecureData("CACHE_user_password");
    await secureStorageService.deleteSecureData("CACHE_user_firstname");
    await secureStorageService.deleteSecureData("CACHE_user_lastname");
    await secureStorageService.deleteSecureData("CACHE_user_bio");
    await secureStorageService.deleteSecureData("CACHE_user_instaprofilelink");
    await secureStorageService
        .deleteSecureData("CACHE_user_profilepicturepath");
  }

  Future cacheBusinessAccount(BusinessAccount businessAccount) async {
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_cached", "true");
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_id", businessAccount.id);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_username", businessAccount.username);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_email", businessAccount.email);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_password", businessAccount.password);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_name", businessAccount.name);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_bio", businessAccount.bio);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_address", businessAccount.address);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_profilepicturepath",
        businessAccount.profilePicturePath);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_instaprofilelink",
        businessAccount.instaProfileLink);
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_latitude", businessAccount.latitude.toString());
    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_longitude",
        businessAccount.longitude.toString());

    double currentTime = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

    currentTime = currentTime + 60 * CACHE_EXPIRATION_MINUTES;

    await secureStorageService.writeSecureData(
        "CACHE_businessaccount_expiration", currentTime.toString());
  }

  Future<bool> isBusinessAccountCacheValid() async {
    if (await secureStorageService
            .readSecureData("CACHE_businessaccount_cached") !=
        "true") {
      return false;
    }

    double expirationTime = double.parse(await secureStorageService
        .readSecureData("CACHE_businessaccount_expiration"));

    double currentTime = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

    return expirationTime > currentTime;
  }

  Future<BusinessAccount> getBusinessAccountFromCache() async {
    String id =
        await secureStorageService.readSecureData("CACHE_businessaccount_id");
    String username = await secureStorageService
        .readSecureData("CACHE_businessaccount_username");
    String email = await secureStorageService
        .readSecureData("CACHE_businessaccount_email");
    String password = await secureStorageService
        .readSecureData("CACHE_businessaccount_password");
    String name =
        await secureStorageService.readSecureData("CACHE_businessaccount_name");
    String bio =
        await secureStorageService.readSecureData("CACHE_businessaccount_bio");
    String address = await secureStorageService
        .readSecureData("CACHE_businessaccount_address");
    String profilePicturePath = await secureStorageService
        .readSecureData("CACHE_businessaccount_profilepicturepath");
    String instaProfileLink = await secureStorageService
        .readSecureData("CACHE_businessaccount_instaprofilelink");
    double latitude = double.parse(await secureStorageService
        .readSecureData("CACHE_businessaccount_latitude"));
    double longitude = double.parse(await secureStorageService
        .readSecureData("CACHE_businessaccount_longitude"));

    return BusinessAccount(
        id: id,
        username: username,
        email: email,
        password: password,
        name: name,
        bio: bio,
        address: address,
        profilePicturePath: profilePicturePath,
        instaProfileLink: instaProfileLink,
        latitude: latitude,
        longitude: longitude);
  }

  Future clearBusinessAccountCache() async {
    await secureStorageService.deleteSecureData("CACHE_businessaccount_cached");
    await secureStorageService.deleteSecureData("CACHE_businessaccount_id");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_username");
    await secureStorageService.deleteSecureData("CACHE_businessaccount_email");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_password");
    await secureStorageService.deleteSecureData("CACHE_businessaccount_name");
    await secureStorageService.deleteSecureData("CACHE_businessaccount_bio");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_address");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_profilepicturepath");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_instaprofilelink");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_latitude");
    await secureStorageService
        .deleteSecureData("CACHE_businessaccount_longitude");
  }
}
