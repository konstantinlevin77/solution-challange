import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/dataLoaders/user_data_loader.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/cache_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:solution_challange_app/src/services/user_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserProfileScreenTree extends StatelessWidget {
  final User user;

  const UserProfileScreenTree({required this.user});

  // Function to launch Instagram profile link
  void _launchInstagramProfile(BuildContext context, profileLink) async {
    launchUrlString(profileLink);
  }

  @override
  Widget build(BuildContext context) {
    return buildWidgetTree(context, user);
  }

  Widget buildWidgetTree(BuildContext context, user) {
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
                      user.username,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                      child: InkWell(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.pushNamed(context, "/user-profile-edit");
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: InkWell(
                        child: const Icon(Icons.logout),
                        onTap: () {
                          UserService(baseUrl: BASE_URL).logoutUser();
                          CacheService(
                                  secureStorageService: SecureStorageService())
                              .clearUserCache();
                          Navigator.pushReplacementNamed(
                              context, "/user-login");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200,
                height: 200,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/user_placeholder.png', // Local asset name
                  image: user.profilePicturePath,
                  fit: BoxFit
                      .cover, // This is to make the image fit nicely in the box. You can remove this if not needed.
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/user_placeholder.png'); // Local asset name for error image
                  },
                ),
              ),
              Text(
                user.bio,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
              Visibility(
                visible: user.instaProfileLink != null &&
                    user.instaProfileLink.isNotEmpty,
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
                              context, user.instaProfileLink);
                        },
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/user-profile-reviews");
                  },
                  child: const Text(
                    "User Reviews",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserDataLoader.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return UserProfileScreenTree(
            user: user,
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

