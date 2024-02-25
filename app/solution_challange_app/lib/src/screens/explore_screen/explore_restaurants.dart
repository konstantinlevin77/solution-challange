import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/screens/explore_screen/widgets/restaurant_list_tile_widget.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';

class ExploreRestaurantsScreen extends StatelessWidget {
  const ExploreRestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RestaurantListViewWidget(
      restaurantFuture: BusinessAccountService(baseUrl: BASE_URL)
          .getAllBusinessAccounts(),
    );
  }
}

// ... other code ...

class RestaurantListViewWidget extends StatelessWidget {
  final Future<List<BusinessAccount>> restaurantFuture;

  const RestaurantListViewWidget({
    Key? key,
    required this.restaurantFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BusinessAccount>>(
      future: restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No restaurants available.');
        } else {
          List<BusinessAccount> restaurants = snapshot.data!;
          return Expanded( // Wrap ListView.builder with Expanded
            child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantListTileWidget(
                  restaurant: restaurants[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}

// ... other code ...
