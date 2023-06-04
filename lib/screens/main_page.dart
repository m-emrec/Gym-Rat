import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/screens/diet_page.dart';
import 'package:gym_rat_v2/screens/track_page.dart';
import 'package:gym_rat_v2/screens/workouts_page.dart';

import '../utils/Custom Widgets/navigationBar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gym Rat",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
        actions: [
          //* Profile button
          GestureDetector(
            onTap: () => FirebaseAuth.instance.signOut(),
            child: Image.asset(
              filterQuality: FilterQuality.high,
              "lib/assets/images/user_icon.webp",
            ),
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [
          WorkoutsPage(),
          DietPage(),
          TrackPage(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        pageController: _controller,
      ),
    );
  }
}
