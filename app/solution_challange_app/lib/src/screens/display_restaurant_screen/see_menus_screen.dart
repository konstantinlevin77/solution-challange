import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/screens/display_restaurant_screen/widgets/menu_list_view_widget.dart';
import 'package:solution_challange_app/src/services/menu_service.dart';

class SeeMenusScreen extends StatelessWidget {
  const SeeMenusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BusinessAccount restaurant =
        ModalRoute.of(context)!.settings.arguments as BusinessAccount;

    return Scaffold(
        body: MenuListViewWidget(
            menusFuture: MenuService(baseUrl: BASE_URL)
                .getMenusByBusinessId(restaurant.id)));
  }
}
