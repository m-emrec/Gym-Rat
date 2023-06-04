import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_rat_v2/Theme/theme_manager.dart';
import 'package:gym_rat_v2/provider/auth_provider.dart';
import 'package:gym_rat_v2/provider/cycle_provider.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:gym_rat_v2/routes.dart';
import 'package:gym_rat_v2/screens/auth_page.dart';
import 'package:gym_rat_v2/screens/get_started_screen.dart';
import 'package:gym_rat_v2/screens/login_page_screen.dart';
import 'package:gym_rat_v2/screens/sign_up_page.dart';
import 'Theme/theme.dart';
import 'screens/workouts_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: kCanvasColor,
        // systemStatusBarContrastEnforced: true,
        statusBarIconBrightness: Brightness.light),
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
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CycleProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym Rat',
        theme: lightTheme,
        themeMode: themeMode,
        initialRoute: AuthPage.routeName,
        routes: AppRoutes().appRoutes,
      ),
    );
  }
}
