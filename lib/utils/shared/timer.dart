import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

class TimerBar extends StatefulWidget {
  const TimerBar({
    super.key,
    required this.duration,
    this.disposeFunc,
  });

  final Duration duration;
  final Function? disposeFunc;
  @override
  State<TimerBar> createState() => _TimerBarState();
}

class _TimerBarState extends State<TimerBar> {
  double progress = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        progress += 1 * 0.01;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    /// if @[disposeFunc] is null then return an empty function.
    widget.disposeFunc == null ? () {} : widget.disposeFunc!();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress / widget.duration.inSeconds,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
            color: AppColors.kCanvasColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 0,
                color: AppColors.kPrimary,
              ),
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 3,
                spreadRadius: 0,
                color: AppColors.kPrimary,
              ),
            ],
          ),
          width: constraints.maxWidth,
          height: 3,
        ),
      );
    });
  }
}
