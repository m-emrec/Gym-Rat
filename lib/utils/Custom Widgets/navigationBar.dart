import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        setState(
          () {
            currentIndex = value;
            widget.pageController.jumpToPage(value);
          },
        );
      },
      showUnselectedLabels: false,
      selectedItemColor: AppColors.kTextColor,
      items: [
        // Workouts page button
        BottomNavigationBarItem(
          tooltip: "Workouts",
          label: "Workouts",
          icon: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              "lib/assets/images/dumbell.png",
              scale: 0.5,
              cacheHeight: 75,
            ),
          ),
        ),
        // Diet page Button
        BottomNavigationBarItem(
          tooltip: "Diet",
          label: "Diet",
          icon: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              "lib/assets/images/dumbell.png",
              scale: 0.5,
              cacheHeight: 75,
            ),
          ),
        ),
        // Track page button
        BottomNavigationBarItem(
          tooltip: "Track",
          label: "Track",
          icon: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              "lib/assets/images/dumbell.png",
              scale: 0.5,
              cacheHeight: 75,
            ),
          ),
        ),
      ],
    );
  }
}
