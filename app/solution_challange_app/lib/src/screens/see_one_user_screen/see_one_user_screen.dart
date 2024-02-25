import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SeeOneUserScreen extends StatelessWidget {
  const SeeOneUserScreen({
    super.key,
  });

  // Function to launch Instagram profile link
  void _launchInstagramProfile(BuildContext context, profileLink) async {
    launchUrlString(profileLink);
  }

  @override
  Widget build(BuildContext context) {
    return buildWidgetTree(context);
  }

  Widget buildWidgetTree(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      body: Center(
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
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        'assets/user_placeholder.png', // Local asset name
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
