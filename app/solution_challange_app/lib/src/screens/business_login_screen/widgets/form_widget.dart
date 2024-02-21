import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';

class BusinessLoginFormWidget extends StatefulWidget {
  const BusinessLoginFormWidget({super.key});

  @override
  State<BusinessLoginFormWidget> createState() =>
      _BusinessLoginFormWidgetState();
}

class _BusinessLoginFormWidgetState extends State<BusinessLoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text(
          "Business Username:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: TextFormField(
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Business username can't be empty.";
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
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password can't be empty.";
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
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            child: const Text(
              "LOGIN",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String username = usernameController.text;
                String password = passwordController.text;

                BusinessAccountService(baseUrl: BASE_URL)
                    .loginBusinessAccount(username, password)
                    .then((value) {
                  if (value) {
                    Navigator.pushReplacementNamed(context, "/main");
                  }
                  if (!value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Username or password is wrong")));
                  }
                });
              }
              setState(() {});
            },
          ),
        )
      ]),
    );
  }
}
