import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/utils/Boxes/archive.dart';
import 'package:gym_rat_v2/utils/Boxes/workouts_container.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/appBar.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customTitle.dart';

import '../utils/Custom Widgets/navigationBar.dart';

class WorkoutsMainPage extends StatelessWidget {
  const WorkoutsMainPage({super.key});

  static const routeName = "workouts-main-page";

  @override
  Widget build(BuildContext context) {
    final String? _userName = FirebaseAuth.instance.currentUser?.displayName;

    //* contains New Cycle and New Workout buttons
    Widget buttonContainer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //* add new workout Cycle button
          Tooltip(
            message: "Click to add new Cycle",
            child: OutlinedButton(
              onPressed: () => {},
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.kIconColor,
                  ),
                  Text(
                    "New Cycle",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Just for some spacing
          const SizedBox(
            width: 10,
          ),

          //*  add new workout button
          Tooltip(
            message: "Click to add new Workout",
            child: OutlinedButton(
              onPressed: () => {},
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.kIconColor,
                  ),
                  Text(
                    "New Workout",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Gym Rat",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18)),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(
            title: "$_userName,",
            subtitle: "Your Workouts",
          ),
          buttonContainer,
          Divider(
            indent: 15,
            endIndent: 15,
            color: Theme.of(context).primaryColor,
            thickness: 3,
          ),
          const Flexible(
            // ? buradaki flex değerini değiştir sonradan
            flex: 5,
            child: WorkoutsBox(),
          ),
          const Flexible(
            child: ArchiveBox(),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

/*

Text(
              "Workouts",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "Title",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Subtitle , Subtitle , Subtitle , Subtitle , ",
              style: Theme.of(context).textTheme.displaySmall,
            )

*/
