import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/image_service.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

class UserSignupFormWidget extends StatefulWidget {
  const UserSignupFormWidget({super.key});

  @override
  State<UserSignupFormWidget> createState() => _UserSignupFormWidgetState();
}

class _UserSignupFormWidgetState extends State<UserSignupFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final instaProfileLinkController = TextEditingController();
  final imagePicker = ImagePicker();
  File? image;

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
              controller: usernameController,
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
              controller: firstNameController,
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
              controller: lastNameController,
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
              controller: emailController,
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
            "Password:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password can't be empty.";
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
              controller: bioController,
            ),
          ),
          const Text(
            "Profile Picture:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () async {
              final img =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
                if (img != null) {
                  image = File(img.path);
                }
              });
            },
            child: const Text("Pick an image."),
          ),
          const Text(
            "Instagram Profile Link:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: instaProfileLinkController,
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
                "Sign up",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String url = '';

                  if (image != null) {
                    print("SOMETHING IN THE WAYY");
                    url = await ImageService().uploadImage(
                        image!, "solutionchallange-repo_cloudbuild");
                  }

                  var u = User(
                    id: "",
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    bio: bioController.text,
                    profilePicturePath: url,
                    instaProfileLink: instaProfileLinkController.text,
                  );
                  UserService(baseUrl: BASE_URL).registerUser(u).then((value) {
                    if (value) {
                      Navigator.pushReplacementNamed(context, "/user-login");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("User is succesfully signed up.")));
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
