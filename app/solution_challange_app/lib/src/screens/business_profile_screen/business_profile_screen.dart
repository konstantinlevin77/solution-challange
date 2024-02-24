import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/dataLoaders/business_account_data_loader.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';
import 'package:solution_challange_app/src/services/cache_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BusinessAccountProfileScreenTree extends StatelessWidget {
  final BusinessAccount businessAccount;

  const BusinessAccountProfileScreenTree({required this.businessAccount});

  // Function to launch Instagram profile link
  void _launchInstagramProfile(BuildContext context, profileLink) async {
    launchUrlString(profileLink);
  }

  @override
  Widget build(BuildContext context) {
    return buildWidgetTree(context, businessAccount);
  }

  Widget buildWidgetTree(BuildContext context, businessAccount) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      businessAccount.username,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                      child: InkWell(
                        child: const Icon(Icons.restaurant_menu),
                        onTap: () {
                          // TODO: Navigate to the add menu screen.
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: InkWell(
                        child: const Icon(Icons.logout),
                        onTap: () {
                          BusinessAccountService(baseUrl: BASE_URL)
                              .logoutBusinessAccount();
                          CacheService(
                                  secureStorageService: SecureStorageService())
                              .clearBusinessAccountCache();
                          Navigator.pushReplacementNamed(
                              context, "/user-login");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                width: 100,
                height: 100,
                child: const Placeholder(),
              ),
               Text(
                businessAccount.address,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                businessAccount.bio,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
              Visibility(
                visible: businessAccount.instaProfileLink != null &&
                    businessAccount.instaProfileLink.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // TODO: Change this with an actual insta logo
                    children: [
                      const Icon(Icons.photo_camera),
                      InkWell(
                        child: const Text("INSTA PROFILE"),
                        onTap: () {
                          _launchInstagramProfile(
                              context, businessAccount.instaProfileLink);
                        },
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to the see menus screen.
                  },
                  child: const Text(
                    "Menus",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessAccountProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BusinessAccount>(
      future: BusinessAccountDataLoader.getBusinessAccountData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final businessAccount = snapshot.data!;
          return BusinessAccountProfileScreenTree(
            businessAccount: businessAccount,
          );
        } else {
          return const Text(
            'Something went wrong.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          );
        }
      },
    );
  }
}
