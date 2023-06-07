import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/shared/stats_widget.dart';

import '../shared/customTitle.dart';

class HelloWidget extends StatefulWidget {
  const HelloWidget({
    super.key,
  });
  @override
  State<HelloWidget> createState() => _HelloWidgetState();
}

class _HelloWidgetState extends State<HelloWidget> {
  late final String? _userName;
  @override
  void initState() {
    super.initState();
    _userName = FirebaseAuth.instance.currentUser?.displayName;
  }

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CustomTitle(
        title: "Hello $_userName",
        subtitle: "Here is your workouts.",
      ),
      const StatsWidget(),
    ];
    return SizedBox(
      width: double.maxFinite,
      height: 150,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        itemCount: 2,
        itemBuilder: (context, index) {
          Future.delayed(
            const Duration(milliseconds: 750),
            () => _controller.animateToPage(1,
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeIn),
          );

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              pages[index],
            ],
          );
        },
      ),
    );
  }
}
