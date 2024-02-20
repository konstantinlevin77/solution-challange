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
            margin: const EdgeInsets.all(20),
            height: 200,
            width: 200,
            child: const Placeholder(
              color: Colors.blueGrey,
            ),
          ),
          const LoginFormWidget(),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Need an account? ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20,10,20,10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("LOGIN/SIGNUP",style: TextStyle(fontWeight: FontWeight.w400),),
                Text(" here if you are a business owner",style: TextStyle(fontWeight: FontWeight.w400),),
              ],
            ),
          )
        ],
      )),
    ));
  }
}
