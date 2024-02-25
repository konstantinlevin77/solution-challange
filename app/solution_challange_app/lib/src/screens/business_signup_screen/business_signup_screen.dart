import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/business_signup_screen/widgets/form_widget.dart';

class BusinessSignupScreen extends StatelessWidget {
  const BusinessSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: const Text(
                  "Sign up to share your business with the world!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const BusinessSignupFormWidget(),
              
            ],
          ),
        ),
      ),
    );
  }
}
