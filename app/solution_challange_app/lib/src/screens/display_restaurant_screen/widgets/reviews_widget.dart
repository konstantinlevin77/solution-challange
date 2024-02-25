import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/review.dart';
import 'package:solution_challange_app/src/screens/user_profile_reviews_screen/widgets/review_list_tile_widget.dart';

class ReviewListViewWidget extends StatelessWidget {
  final Future<List<Review>> reviewsFuture;

  const ReviewListViewWidget({Key? key, required this.reviewsFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Review>>(
        future: reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No reviews available.');
          } else {
            List<Review> reviews = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewListTileWidget(review: reviews[index]);
              },
            );
          }
        },
      ),
    );
  }
}