import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/dataLoaders/user_data_loader.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/screens/user_profile_edit_screen/widgets/user_profile_edit_widget.dart';

class UserProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserDataLoader.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: const Text(
                  "Edit Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
               UserProfileEditWidget(user: user,)
            ],
          ),
        ),
      ),
    );
        } else {
          return const Text(
            'Something went wrong.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          );
        }
      },
    );
  }
}
