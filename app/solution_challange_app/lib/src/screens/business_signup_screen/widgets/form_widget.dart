import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';

class BusinessSignupFormWidget extends StatefulWidget {
  const BusinessSignupFormWidget({super.key});

  @override
  State<BusinessSignupFormWidget> createState() =>
      _BusinessSignupFormWidgetState();
}

class _BusinessSignupFormWidgetState extends State<BusinessSignupFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final addressController = TextEditingController();
  final instaProfileLinkController = TextEditingController();

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
            "Name:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "First name can't be empty.";
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
            "Address:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: addressController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Adress can't be empty.";
                }

                locationFromAddress(addressController.text).then((locations) {
                  if (locations.isEmpty) {
                    return "No place can be found in the adress";
                  } else {
                    print(locations.first.latitude);
                    print(locations.first.longitude);
                  }
                });

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
          //TODO: Implement profile picture upload right here!!!!!!!
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
          const Text(
            "You can later add your menus from your profile",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 13,
                fontWeight: FontWeight.bold),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  locationFromAddress(addressController.text).then((locations) {
                    final businessAccount = BusinessAccount(
                        id: "",
                        username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        bio: bioController.text,
                        address: addressController.text,
                        profilePicturePath: "",
                        instaProfileLink: instaProfileLinkController.text,
                        latitude: locations.first.latitude,
                        longitude: locations.first.longitude);

                    BusinessAccountService(baseUrl: BASE_URL)
                        .registerBusinessAccount(businessAccount)
                        .then((result) {
                      if (result) {
                        Navigator.pushReplacementNamed(context, "/user-login");
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Business account is succesfully signed up.")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Something went wrong.")));
                      }
                    });
                  });

                  // TODO: Profile picture path!!
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
