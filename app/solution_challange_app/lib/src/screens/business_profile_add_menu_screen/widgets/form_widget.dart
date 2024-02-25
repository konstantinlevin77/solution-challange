import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/dataLoaders/business_account_data_loader.dart';
import 'package:solution_challange_app/src/models/menu.dart';
import 'package:solution_challange_app/src/services/menu_service.dart';

class BusinessAddMenuFormWidget extends StatefulWidget {
  const BusinessAddMenuFormWidget({super.key});

  @override
  State<BusinessAddMenuFormWidget> createState() =>
      _BusinessAddMenuFormWidgetState();
}

class _BusinessAddMenuFormWidgetState extends State<BusinessAddMenuFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ingredientsController = TextEditingController();
  final priceController = TextEditingController();
  bool isGlutenFree = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Menu Name:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Menu name can't be empty.";
                }
                return null;
              },
            ),
          ),
          const Text(
            "Ingredients:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: ingredientsController,
              decoration: const InputDecoration(
                  labelText: "Put commas between the ingredients."),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingredients can't be empty.";
                }
                return null;
              },
            ),
          ),
          const Text(
            "Price:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: TextFormField(
              controller: priceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Price can't be empty.";
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isGlutenFree,
                onChanged: (value) {
                  setState(() {
                    isGlutenFree = value!;
                  });
                },
              ),
              const Text('This menu is gluten free'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 220, 219, 219),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "Add menu!",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BusinessAccountDataLoader.getBusinessAccountData().then((ba) {
                    // Leave image path empty for now.
                    Menu m = Menu(
                        id: "",
                        name: nameController.text,
                        businessId: ba.id,
                        businessName: ba.name,
                        ingredients: ingredientsController.text,
                        price: double.parse(priceController.text),
                        exampleImagePath: "",
                        isGlutenFree: isGlutenFree);

                    MenuService(baseUrl: BASE_URL).addMenu(m).then((result) {
                      if (result) {
                        Navigator.pushReplacementNamed(
                            context, "/business-profile-menu");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Menu is succesfully added.")));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Something went wrong.")));
                      }
                    });
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
