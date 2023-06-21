import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/snackbars.dart';

import '../../logger.dart';

class CustomSnack extends StatefulWidget {
  CustomSnack({
    super.key,
    required this.content,
    required this.label,
    this.acceptFunc,
    this.snackType = SnackType.primary,
    this.sDuration,
    this.declineFunc,
    this.disposeFunction,
    this.declineLabel,
    this.acceptLabel,
  });
  final Widget content;
  final String label;

  /// The text that will be written on the snackbar body.
  final String? declineLabel;
  final String? acceptLabel;

  ///

  /// Which type of snack you want to show.
  /// @[backgroundColor] , [duration] and some properties will be changed dependimng on the @[SnackType]
  final SnackType? snackType;

  /// Can be null.
  /// If defined than @[SnakcBar] will use this instead of pre-defined durations.
  final Duration? sDuration;

  /// The function that will be called after user accepted something.
  ///  ex:
  ///       Let'say user wanted to delete something if he taps "Yes" button then this function will be called.
  final Function? acceptFunc;

  /// The function that will be called after user declined something.
  ///  ex:
  ///       Let'say user wanted to delete something if he taps "No" button then this function will be called.
  final Function? declineFunc;

  /// Can be [Null]
  /// What will happen after this [Snack] removed from the screen.
  final Function? disposeFunction;

  bool _isDeclined = false;

  Function get _declineFunc => declineFunc ?? () {};

  ValueNotifier<bool> a = ValueNotifier(false);

  @override
  State<CustomSnack> createState() => _CustomSnackState();
}

class _CustomSnackState extends State<CustomSnack> {
  @override
  Widget build(BuildContext context) {
    return Snack(
        context: context, content: widget.content, label: widget.label);
  }
}
