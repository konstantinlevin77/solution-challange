import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/business_account.dart';

class DisplayRestaurantScreen extends StatelessWidget {
  const DisplayRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BusinessAccount restaurant =
        ModalRoute.of(context)!.settings.arguments as BusinessAccount;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 150,
              color: Colors.grey,
            ),
            Text(
              restaurant.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              restaurant.bio,
              maxLines: null,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 14),
            ),
            // TODO: Implement on pressed.
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/see-menus",
                      arguments: restaurant);
                },
                child: const Text(
                  "See menus!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
