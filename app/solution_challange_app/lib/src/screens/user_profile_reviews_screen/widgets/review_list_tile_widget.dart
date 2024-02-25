import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/review.dart';
import 'package:solution_challange_app/src/models/user.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

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
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.orange,
            ),
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
              FutureBuilder<User>(
                future:
                    UserService(baseUrl: BASE_URL).getUserById(review.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("");
                  } else if (snapshot.hasError) {
                    return const Text("");
                  } else if (!snapshot.hasData) {
                    return const Text("");
                  } else {
                    User user = snapshot.data!;
                    return Row(
                      children: [
                        const Icon(Icons.person),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/see-one-user",arguments: user);
                          },
                          child: Text(user.username),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
