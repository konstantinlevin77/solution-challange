import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/menu.dart';
import 'package:solution_challange_app/src/models/review.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';
import 'package:solution_challange_app/src/services/reviews_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int starsGiven = 1;

  @override
  Widget build(BuildContext context) {
    final Menu menu = ModalRoute.of(context)!.settings.arguments as Menu;
    final _formKey = GlobalKey<FormState>();
    final reviewController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reviewing: ${menu.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  starsGiven = rating.toInt();
                });
              },
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your Review: "),
                    Container(
                      margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                      child: TextFormField(
                        controller: reviewController,
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Review can't be empty.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 220, 219, 219),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                        ),
                        child: const Text(
                          "Add review",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Implement onPressed

                            SecureStorageService()
                                .readSecureData("id")
                                .then((userId) {
                              final review = Review(
                                  id: "",
                                  userId: userId,
                                  menuId: menu.id,
                                  businessId: menu.businessId,
                                  menuName: menu.name,
                                  businessName: "",
                                  stars: starsGiven,
                                  review: reviewController.text);

                              ReviewsService(baseUrl: BASE_URL)
                                  .addReview(review)
                                  .then((result) {
                                if (result) {
                                  BusinessAccountService(baseUrl: BASE_URL)
                                      .getBusinessAccountById(menu.businessId)
                                      .then((restaurant) {
                                    Navigator.pushReplacementNamed(
                                        context, "/display-restaurant",
                                        arguments: restaurant);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Your review is succesfully added.")));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Something went wrong.")));
                                }
                              });
                            });
                          }
                        },
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
