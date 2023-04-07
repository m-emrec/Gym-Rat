import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_rat_v2/screens/auth_page.dart';
import 'package:gym_rat_v2/screens/login_page_screen.dart';
import 'package:gym_rat_v2/screens/sign_up_page.dart';
import 'screens/workouts_main_page_screen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // systemStatusBarContrastEnforced: true,
      statusBarIconBrightness: Brightness.dark
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Rat',
      theme: ThemeData(
        primaryColor: AppColors.kPrimary,
        canvasColor: AppColors.kCanvasColor,
        dividerColor: AppColors.kTextColor,
        textTheme: TextTheme(
          bodySmall: TextStyles.bodySmall,
          titleLarge: TextStyles.titleLarge,
          displaySmall: TextStyles.subtitle,
        ),
      ),
      // TODO: Change this
      initialRoute: AuthPage.routeName,
      routes: {
        "/": (context) => AuthPage(),
        WorkoutsMainPage.routeName: (context) => WorkoutsMainPage(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
      },
    );
  }
}
