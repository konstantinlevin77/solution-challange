import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/screens/user_profile_reviews_screen/widgets/reviews_widget.dart';
import 'package:solution_challange_app/src/services/reviews_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

class UserProfileReviewsScreen extends StatelessWidget {
  const UserProfileReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = "";

    // Using FutureBuilder to handle asynchronous operation
    return FutureBuilder(
      // Your future that fetches the data
      future: SecureStorageService().readSecureData("id"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Data has been fetched successfully
          userId = snapshot.data!;

          // Now, fetch reviews using the user id
          final reviewsFuture =
              ReviewsService(baseUrl: BASE_URL).getReviewsByUserId(userId);

          return Scaffold(
            body: Center(
              child: ReviewListViewWidget(reviewsFuture: reviewsFuture),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error state
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        } else {
          // Still loading data
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
