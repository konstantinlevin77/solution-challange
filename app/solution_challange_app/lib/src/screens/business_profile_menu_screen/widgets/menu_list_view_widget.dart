import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/menu.dart';
import 'package:solution_challange_app/src/screens/business_profile_menu_screen/widgets/menu_list_tile_widget.dart';

class MenuListViewWidget extends StatelessWidget {
  final Future<List<Menu>> menusFuture;

  const MenuListViewWidget({Key? key, required this.menusFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Menu>>(
        future: menusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No menus available.');
          } else {
            List<Menu> menus = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                return MenuListTileWidget(menu: menus[index]);
              },
            );
          }
        },
      ),
    );
  }
}