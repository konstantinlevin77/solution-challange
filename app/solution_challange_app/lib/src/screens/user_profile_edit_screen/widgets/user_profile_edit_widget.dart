import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/cache_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

// ignore: must_be_immutable
class UserProfileEditWidget extends StatefulWidget {
  User user;

  UserProfileEditWidget({required this.user});

  @override
  State<UserProfileEditWidget> createState() => _UserProfileEditWidgetState();
}

class _UserProfileEditWidgetState extends State<UserProfileEditWidget> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final instaProfileLinkController = TextEditingController();
  final cacheService =
      CacheService(secureStorageService: SecureStorageService());

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Username:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: usernameController..text=widget.user.username,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username can't be empty.";
                }
                return null;
              },
            ),
          ),
          const Text(
            "First Name:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: firstNameController..text=widget.user.firstName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "First name can't be empty.";
                }
                return null;
              },
            ),
          ),
          const Text(
            "Last Name:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: lastNameController..text=widget.user.lastName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Last name can't be empty.";
                }
                return null;
              },
            ),
          ),
          const Text(
            "Email:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: emailController..text=widget.user.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email can't be empty.";
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
                  return "Please type a valid email.";
                }
                return null;
              },
            ),
          ),
          const Text(
            "Biography:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: bioController..text=widget.user.bio,
            ),
          ),
          const Text(
            "Profile Picture:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //TODO: Implement profile picture upload right here!!!!!!!
          const Text(
            "Instagram Profile Link:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: instaProfileLinkController..text=widget.user.instaProfileLink,
              validator: (value) {
                final instagramRegex = RegExp(
                    r"^(https?:\/\/)?(www\.)?instagram\.com\/[a-zA-Z0-9_.]+\/?$",
                    caseSensitive: false);
                if ((value!.isNotEmpty) && !instagramRegex.hasMatch(value)) {
                  return "Please type a valid instagram link.";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 220, 219, 219),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "Edit",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.user.username = usernameController.text;
                  widget.user.firstName = firstNameController.text;
                  widget.user.lastName = lastNameController.text;
                  widget.user.email = emailController.text;
                  widget.user.bio = bioController.text;
                  widget.user.instaProfileLink =
                      instaProfileLinkController.text;

                  UserService(baseUrl: BASE_URL)
                      .updateUser(widget.user)
                      .then((result) {
                    if (result) {
                      CacheService(secureStorageService: SecureStorageService())
                          .cacheUser(widget.user);
                      Navigator.pushReplacementNamed(context, "/main");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Succesfully updated.")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Something went wrong.")));
                    }
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
