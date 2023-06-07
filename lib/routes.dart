import 'package:gym_rat_v2/screens/start_new_cycle_screen.dart';
import 'package:gym_rat_v2/screens/add_new_workout_screen.dart';
import 'package:gym_rat_v2/screens/auth_page.dart';
import 'package:gym_rat_v2/screens/get_started_screen.dart';
import 'package:gym_rat_v2/screens/login_page_screen.dart';
import 'package:gym_rat_v2/screens/sign_up_page.dart';
import 'package:gym_rat_v2/screens/workouts_page.dart';

class AppRoutes {
  final appRoutes = {
    "/": (context) => const AuthPage(),
    WorkoutsPage.routeName: (context) => const WorkoutsPage(),
    LoginPage.routeName: (context) => LoginPage(),
    SignUpPage.routeName: (context) => const SignUpPage(),
    GetStartedPage.routeName: (context) => GetStartedPage(),
    AddNewWorkoutPage.routeName: (context) => AddNewWorkoutPage(),
    StartNewCyclePage.routeName: (context) => StartNewCyclePage(),
  };
}
