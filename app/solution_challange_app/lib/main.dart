import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/screens/business_login_screen/business_login_screen.dart';
import 'package:solution_challange_app/src/screens/home_screen/home_screen.dart';
import 'package:solution_challange_app/src/screens/user_login_screen/user_login_screen.dart';
import 'package:solution_challange_app/src/screens/user_profile_edit_screen/user_profile_edit_screen.dart';
import 'package:solution_challange_app/src/screens/user_signup_screen/user_signup_screen.dart';
import 'package:solution_challange_app/src/services/auth_service.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';
import 'package:solution_challange_app/src/services/storage_service.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/business-login": (context) => const BusinessAccountLoginScreen(),
        "/user-login": (context) => const UserLoginScreen(),
        "/main": (context) => const HomeScreen(),
        "/user-signup":(context) => const UserSignupScreen(),
        "/user-profile-edit":(context) => UserProfileEditScreen(),
      },
      theme: ThemeData(
        primaryColor: TEXT_FIELD_COLOR,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          accentColor: Colors.deepOrangeAccent,
          brightness: Brightness.light
        ),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.black),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: TEXT_FIELD_COLOR)),
            filled: true,
            fillColor: TEXT_FIELD_COLOR,
          )),
      home: AppEntry(),
    );
  }
}

/*
New State Management system
*/

class AppEntry extends StatefulWidget {
  @override
  _AppEntryState createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  void initState() {
    super.initState();
    checkAuthenticationAndNavigate();
  }

  Future<void> checkAuthenticationAndNavigate() async {
    AuthService authService =
        AuthService(); // Replace with your AuthService instance
    bool isLoggedIn = await authService
        .isLoggedIn(); // Implement isLoggedIn method in your AuthService

    if (isLoggedIn) {
      // User is logged in, navigate to the home page
      Navigator.pushReplacementNamed(context, "/main");
    } else {
      // User is not logged in, navigate to the login page
      Navigator.pushReplacementNamed(context, "/user-login");
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can return any loading or splash screen widget here if needed
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/*
These widgets are just for test purposes.
*/

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _logOut() {
    SecureStorageService().readSecureData("user_type").then((value) {
      if (value == "user") {
        UserService(baseUrl: BASE_URL).logoutUser();
      } else if (value == "business_account") {
        BusinessAccountService(baseUrl: BASE_URL).logoutBusinessAccount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You are logged in bro"),
            ElevatedButton(
                onPressed: () {
                  _logOut();
                  Navigator.pushReplacementNamed(context, "/user-login");
                },
                child: const Text("log out"))
          ],
        ),
      ),
    );
  }
}
