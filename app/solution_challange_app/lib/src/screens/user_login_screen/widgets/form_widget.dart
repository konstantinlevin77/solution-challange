import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text(
          "Username:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: TEXT_FIELD_COLOR,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
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
          "Password:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                filled: true,
                fillColor: TEXT_FIELD_COLOR,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
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
            child: const Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String username = usernameController.text;
                String password = passwordController.text;

                UserService(baseUrl: BASE_URL)
                    .loginUser(username, password)
                    .then((value) {
                  if (!value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Username or password is wrong.")));
                  }
                });
              }
            },
          ),
        )
      ]),
    );
  }
}
