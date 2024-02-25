import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/screens/articles_screen/show_one_article_screen.dart';
import 'package:solution_challange_app/src/screens/business_login_screen/business_login_screen.dart';
import 'package:solution_challange_app/src/screens/business_profile_add_menu_screen/business_profile_add_menu_screen.dart';
import 'package:solution_challange_app/src/screens/business_profile_menu_screen/business_profile_menu_screen.dart';
import 'package:solution_challange_app/src/screens/business_signup_screen/business_signup_screen.dart';
import 'package:solution_challange_app/src/screens/display_restaurant_screen/add_review_screen.dart';
import 'package:solution_challange_app/src/screens/display_restaurant_screen/display_restaurant_screen.dart';
import 'package:solution_challange_app/src/screens/display_restaurant_screen/see_menus_screen.dart';
import 'package:solution_challange_app/src/screens/display_restaurant_screen/see_reviews_screen.dart';
import 'package:solution_challange_app/src/screens/home_screen/home_screen.dart';
import 'package:solution_challange_app/src/screens/see_one_user_screen/see_one_user_screen.dart';
import 'package:solution_challange_app/src/screens/user_login_screen/user_login_screen.dart';
import 'package:solution_challange_app/src/screens/user_profile_edit_screen/user_profile_edit_screen.dart';
import 'package:solution_challange_app/src/screens/user_profile_reviews_screen/user_profile_reviews_screen.dart';
import 'package:solution_challange_app/src/screens/user_signup_screen/user_signup_screen.dart';
import 'package:solution_challange_app/src/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
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
        "/user-signup": (context) => const UserSignupScreen(),
        "/user-profile-edit": (context) => UserProfileEditScreen(),
        "/user-profile-reviews": (context) => const UserProfileReviewsScreen(),
        "/business-signup": (context) => const BusinessSignupScreen(),
        "/business-profile-menu": (context) =>
            const BusinessProfileMenuScreen(),
        "/business-profile-add-menu": (context) =>
            const BusinessProfileAddMenuScreen(),
        "/display-restaurant": (context) => const DisplayRestaurantScreen(),
        "/see-menus": (context) => const SeeMenusScreen(),
        "/add-review": (context) => const AddReviewScreen(),
        "/see-reviews": (context) => const SeeReviewsScreen(),
        "/show-one-article":(context) => const ShowOneArticleScreen(),
        "/see-one-user":(context) =>  SeeOneUserScreen()
      },
      theme: ThemeData(
          primaryColor: TEXT_FIELD_COLOR,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: createMaterialColor(TEXT_FIELD_COLOR),
              accentColor: TEXT_FIELD_COLOR,
              brightness: Brightness.light),
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
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Colors.black),
          toggleButtonsTheme: const ToggleButtonsThemeData(
            color: Color.fromARGB(255, 117, 109, 102),
            selectedColor:Colors.black

          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(backgroundColor: TEXT_FIELD_COLOR,foregroundColor: Colors.black))),
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
