import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/business_account.dart';

class RestaurantListTileWidget extends StatelessWidget {
  final BusinessAccount restaurant;
  const RestaurantListTileWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: ListTile(
          title: Column(
            children: [
              // TODO: This is for image system.
              Container(
                width: 200,
                height: 200,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/business_placeholder.png', // Local asset name
                  image: restaurant.profilePicturePath,
                  fit: BoxFit
                      .cover, // This is to make the image fit nicely in the box. You can remove this if not needed.
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/business_placeholder.png'); // Local asset name for error image
                  },
                ),
              ),
              Text(
                restaurant.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.bio,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/display-restaurant",
            arguments: restaurant);
      },
    );
  }
}
