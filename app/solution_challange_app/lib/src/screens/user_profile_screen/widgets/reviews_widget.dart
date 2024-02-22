import 'package:flutter/material.dart';

class ReviewListViewWidget extends StatelessWidget {
  ReviewListViewWidget({super.key});
  final List<String> reviews = ["Review 1", "Review 2", "Review 3","Review 4","Review 5","Review 6"];

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(reviews[index]),
        );
      },
    ));
  }
}
