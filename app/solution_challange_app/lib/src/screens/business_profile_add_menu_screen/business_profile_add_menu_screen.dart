import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/business_profile_add_menu_screen/widgets/form_widget.dart';

class BusinessProfileAddMenuScreen extends StatelessWidget {
  const BusinessProfileAddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20,30,20,20),
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: const Text(
                    "Add your menu!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              const BusinessAddMenuFormWidget()
            ],
          ),
        ),
      ),
    );
  }
  
}
