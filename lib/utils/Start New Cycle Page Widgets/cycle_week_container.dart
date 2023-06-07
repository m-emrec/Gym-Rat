import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/utils/shared/circle_button.dart';
import 'package:gym_rat_v2/utils/shared/help_box_.dart';

class CycleWeek extends StatefulWidget {
  const CycleWeek({super.key, required this.controllerFunction});

  final Function controllerFunction;

  @override
  State<CycleWeek> createState() => _CycleWeekState();
}

class _CycleWeekState extends State<CycleWeek> {
  final List _cycleWeeks = [
    4,
    6,
    8,
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "How many weeks ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              CircleButton(
                label: "",
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => const HelpBox(
                    helpText: "Choose how many weeeks you want",
                  ),
                ),
                icon: Icons.question_mark,
                radius: 16,
              )
            ],
          ),
        ),
        16.ph(),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.controllerFunction(_cycleWeeks[index]);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? Theme.of(context).focusColor
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                      spreadRadius: 1,
                      color: _selectedIndex == index
                          ? Theme.of(context).focusColor
                          : Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _cycleWeeks[index].toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 16,
                          color: _selectedIndex == index
                              ? Theme.of(context).canvasColor
                              : Theme.of(context).textTheme.labelLarge!.color,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
