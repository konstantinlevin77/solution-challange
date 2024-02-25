import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/menu.dart';
import 'package:solution_challange_app/src/screens/display_restaurant_screen/widgets/reviews_widget.dart';
import 'package:solution_challange_app/src/services/reviews_service.dart';

class SeeReviewsScreen extends StatelessWidget {
  const SeeReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = ModalRoute.of(context)!.settings.arguments as Menu;

    return Scaffold(
      body: Center(
        child: ReviewListViewWidget(
            reviewsFuture:
                ReviewsService(baseUrl: BASE_URL).getReviewsByMenuId(menu.id)),
      ),
    );
  }
}
