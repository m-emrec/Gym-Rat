import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        75,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        shape: const Border(
          bottom: BorderSide(
            color: AppColors.kPrimary,
            width: 2.5,
          ),
        ),
        elevation: 0,
        // App Title
        title: Text("Gym Rat", style: Theme.of(context).textTheme.titleLarge),
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
    );
  }
}
