import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/menu.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

class MenuListTileWidget extends StatelessWidget {
  final Menu menu;

  const MenuListTileWidget({
    super.key,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          children: [
            menu.isGlutenFree
                ? const Row(
                    children: [
                      Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      Text(
                        "This menu is gluten-free.",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                : const Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      Text(
                        "This menu is not gluten-free.",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
            Text(
              menu.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ingredients:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              menu.ingredients,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            Text(
              "Price: ${menu.price.toString()}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            FutureBuilder<String>(
              future: SecureStorageService().readSecureData("user_type"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading state
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Success state
                  bool shouldShowButton;
                  if (snapshot.data == "user") {
                    shouldShowButton = true;
                  } else {
                    shouldShowButton = false;
                  }

                  return shouldShowButton
                      ? Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("See Reviews"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/add-review",
                                    arguments: menu);
                              },
                              child: const Text("Add a review"),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {},
                          child: const Text("See Reviews"),
                        );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
