import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/screens/business_profile_menu_screen/widgets/menu_list_view_widget.dart';
import 'package:solution_challange_app/src/services/menu_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

class BusinessProfileMenuScreen extends StatelessWidget {
  const BusinessProfileMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String businessId = "";

    // Using FutureBuilder to handle asynchronous operation
    return FutureBuilder(
      // Your future that fetches the data
      future: SecureStorageService().readSecureData("id"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Data has been fetched successfully
          businessId = snapshot.data!;

          // Now, fetch reviews using the user id
          final menusFuture =
              MenuService(baseUrl: BASE_URL).getMenusByBusinessId(businessId);

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, "/business-profile-add-menu");
              },
            ),
            body: Center(
              child: MenuListViewWidget(menusFuture: menusFuture),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error state
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        } else {
          // Still loading data
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
