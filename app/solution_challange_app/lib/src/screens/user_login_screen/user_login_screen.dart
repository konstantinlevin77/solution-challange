import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/user_login_screen/widgets/form_widget.dart';

// TODO: make sign up texts clickable, and they should navigate to sign up pages.

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 300,
              height: 300,
              padding: const EdgeInsets.all(30),
              child: const Image(image: AssetImage("assets/logo.jpeg"),fit: BoxFit.cover)),
          const LoginFormWidget(),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Need an account? ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                InkWell(
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/user-signup");
                  },
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed("/business-login");
                  },
                  child: const Text(
                    "LOGIN/SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ),
                const Text(
                  " here if you are a business owner",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      )),
    ));
  }
}
