import 'package:gym_rat_v2/screens/Exercise%20Screens.dart/add_exercise_to_workout_page.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/edit_workout_screen.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/start_new_cycle_screen.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/add_new_workout_screen.dart';
import 'package:gym_rat_v2/screens/Auth%20Screens/auth_page.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/workout_detail_page.dart';
import 'package:gym_rat_v2/screens/get_started_screen.dart';
import 'package:gym_rat_v2/screens/Auth%20Screens/login_page_screen.dart';
import 'package:gym_rat_v2/screens/Auth%20Screens/sign_up_page.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/workouts_page.dart';

class AppRoutes {
  final appRoutes = {
    "/": (context) => const AuthPage(),
    WorkoutsPage.routeName: (context) => const WorkoutsPage(),
    LoginPage.routeName: (context) => LoginPage(),
    SignUpPage.routeName: (context) => const SignUpPage(),
    GetStartedPage.routeName: (context) => GetStartedPage(),
    AddNewWorkoutPage.routeName: (context) => AddNewWorkoutPage(),
    StartNewCyclePage.routeName: (context) => StartNewCyclePage(),
    WorkoutDetailPage.routeName: (context) => WorkoutDetailPage(),
    AddExerciseToWorkoutPage.routeName: (context) => AddExerciseToWorkoutPage(),
    EditWorkoutScreen.routeName: (context) => EditWorkoutScreen(),
  };
}
