import 'package:flutter/material.dart';

import '../../constants.dart';

class ExerciseInstructionContainer extends StatefulWidget {
  const ExerciseInstructionContainer({super.key, required this.instructions});
  final String instructions;

  @override
  State<ExerciseInstructionContainer> createState() =>
      _ExerciseInstructionContainerState();
}

class _ExerciseInstructionContainerState
    extends State<ExerciseInstructionContainer> {
  bool _showText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Show instructions button.
        GestureDetector(
          onTap: () => setState(() {
            _showText = !_showText;
          }),
          child: Row(
            children: [
              _showText
                  ? const Icon(
                      Icons.arrow_drop_up_sharp,
                      color: AppColors.kButtonColor,
                    )
                  : const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: AppColors.kButtonColor,
                    ),
              Text(
                "Show Instructions",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),

        /// Instructions Text
        Visibility(
          visible: _showText,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.instructions,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}
