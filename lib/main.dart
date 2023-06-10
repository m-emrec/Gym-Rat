import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_rat_v2/Theme/theme_manager.dart';
import 'package:gym_rat_v2/provider/auth_provider.dart';
import 'package:gym_rat_v2/provider/cycle_provider.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:gym_rat_v2/routes.dart';
import 'package:gym_rat_v2/screens/Auth%20Screens/auth_page.dart';
import 'Theme/theme.dart';
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
        ChangeNotifierProvider(
          create: (context) => WorkoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExerciseProvider(),
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
