import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/business_profile_screen/business_profile_screen.dart';
import 'package:solution_challange_app/src/screens/user_profile_screen/user_profile_screen.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    const Text("Explore Page"),
    const Text("Map Page"),
    const ProfileScreenWrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: SecureStorageService().readSecureData("user_type"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          // Determine which profile screen to display based on the user type
          switch (snapshot.data) {
            case "user":
              return UserProfileScreen();
            case "business_account":
              return BusinessAccountProfileScreen();
            default:
              return const Center(child: Text("Something went wrong."));
          }
        }
      },
    );
  }
}
