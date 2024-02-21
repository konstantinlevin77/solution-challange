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
            margin: const EdgeInsets.all(20),
            height: 200,
            width: 200,
            child: const Placeholder(
              color: Colors.blueGrey,
            ),
          ),
          const BusinessLoginFormWidget(),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Need a business account? ",
                  style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                ),
                Text(
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),
                )
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
