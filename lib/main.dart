import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:gym_rat_v2/screens/auth_page.dart';
import 'package:gym_rat_v2/screens/get_started_screen.dart';
import 'package:gym_rat_v2/screens/login_page_screen.dart';
import 'package:gym_rat_v2/screens/sign_up_page.dart';
import 'Theme/theme.dart';
import 'screens/workouts_main_page_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // systemStatusBarContrastEnforced: true,
        statusBarIconBrightness: Brightness.dark),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym Rat',
        theme: lightTheme,
        initialRoute: AuthPage.routeName,
        routes: {
          "/": (context) => const AuthPage(),
          WorkoutsMainPage.routeName: (context) => const WorkoutsMainPage(),
          LoginPage.routeName: (context) => LoginPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          GetStartedPage.routeName: (context) => GetStartedPage(),
        },
      ),
    );
  }
}
