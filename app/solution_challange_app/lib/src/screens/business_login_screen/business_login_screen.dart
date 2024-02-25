import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/business_login_screen/widgets/form_widget.dart';

class BusinessAccountLoginScreen extends StatelessWidget {
  const BusinessAccountLoginScreen({super.key});

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
              child: const Image(image: AssetImage("assets/logo.jpeg"),fit: BoxFit.cover,)),
          const BusinessLoginFormWidget(),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Need a business account? ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                InkWell(
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/business-signup");
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
