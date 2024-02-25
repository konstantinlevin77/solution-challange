import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/articles_screen/articles_screen.dart';
import 'package:solution_challange_app/src/screens/explore_screen/explore_restaurants.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<bool> isSelected = [
    true,
    false
  ]; // true for Articles, false for Restaurants

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(25, 80, 50, 20),
            child: const Text(
              "EXPLORE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: ToggleButtons(
              isSelected: isSelected,
              onPressed: (index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
              borderRadius: BorderRadius.circular(20),
              children: [
                Container(
                    width: 100,
                    child: const Center(
                        child: Text(
                      'Articles',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
                Container(
                    width: 100,
                    child: const Center(
                        child: Text(
                      'Restaurants',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Display content based on the selected option
          isSelected[0] ? const ArticlesScreen() : const ExploreRestaurantsScreen(),
        ],
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        'Articles content goes here.',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
