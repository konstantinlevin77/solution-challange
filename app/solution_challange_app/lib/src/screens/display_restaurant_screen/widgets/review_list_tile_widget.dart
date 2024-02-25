import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:solution_challange_app/src/models/review.dart';

class ReviewListTileWidget extends StatelessWidget {
  final Review review;

  const ReviewListTileWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: RatingBarIndicator(
            itemCount: 5,
            rating: review.stars.toDouble(),
            itemSize: 25,
            itemBuilder: (context, index) => const Icon(Icons.star,color: Colors.orange,),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.menuName,
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              Text(
                review.businessName,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                review.review,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ],
          )),
    );
  }
}
