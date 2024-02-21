import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/screens/business_login_screen/business_login_screen.dart';
import 'package:solution_challange_app/src/screens/user_login_screen/user_login_screen.dart';
import 'package:solution_challange_app/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:solution_challange_app/src/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/business-login": (context) => const BusinessAccountLoginScreen()
      },
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
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
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return authService.isLoggedIn
        ? const MainScreen()
        : const UserLoginScreen();
  }
}

/*
These widgets are just for test purposes.
*/

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _logoutUser() {
    print("test??");
    UserService(baseUrl: BASE_URL).logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You are logged in bro"),
            ElevatedButton(onPressed: _logoutUser, child: const Text("log out"))
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Log in bro")),
    );
  }
}
