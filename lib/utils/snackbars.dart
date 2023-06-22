import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/utils/shared/timer.dart';

enum SnackType {
  error,
  danger,
  warning,
  primary,
  widget,
  info,
}

// ignore: must_be_immutable
class Snack extends SnackBar {
  Snack({
    super.key,
    required this.context,
    required super.content,
    required this.label,
    this.acceptFunc,
    this.snackType = SnackType.primary,
    this.sDuration,
    this.declineFunc,
    this.disposeFunction,
    this.declineLabel,
    this.acceptLabel,
  });

  ///
  final BuildContext context;

  /// The text that will be written on the [Snack] body.
  final String label;

  /// Can be [Null].
  ///   This will used as [declineButton]'s label.
  final String? declineLabel;

  /// Can be [Null]
  ///   This will used as [acceptButton]'s label.
  final String? acceptLabel;

  /// Which type of snack you want to show.
  /// [backgroundColor] , [duration] and some properties will be changed depending on the [SnackType]
  final SnackType? snackType;

  /// Can be [Null].
  /// If defined than [SnackBar] will use this instead of pre-defined durations.
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

  /// If user calls the [declineFunc] this will set as [true].
  bool _isDeclined = false;

  /// Default [declineFunc] if [declineFunc] is [Null] this funtion will be used.
  Function get _declineFunc =>
      declineFunc ??
      () {
        _isDeclined = true;
      };

  /// Just to reach to value of [_isDeclined] from outside of this class.
  bool getIsDeclined() {
    if (_isDeclined) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget get content {
    //* if the the [acceptLabel] is not null but [acceptFunc] is null then throw an error.
    if (acceptLabel != null && acceptFunc == null) {
      throw Exception(
        "You have to provide acceptFunc or remove the acceptLabel.",
      );
    }

    switch (snackType) {
      ///* if the [SnackType] is widget the return content which is givn to the @[Snack].
      case SnackType.widget:
        return super.content;

      ///* By Default return a Text, button and timer,
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Body of the snackbar.
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// [label]
                  Flexible(
                    child: Text(
                      label,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: AppColors.kCanvasColor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  //* if [acceptLabel] is not [Null] then show accept button
                  acceptLabel == null
                      ? const SizedBox(
                          height: 64,
                        )
                      : TextButton(
                          style: context.theme.textButtonTheme.style!.copyWith(
                            foregroundColor: const MaterialStatePropertyAll(
                                AppColors.kCanvasColor),
                          ),
                          onPressed: () {
                            acceptFunc!();

                            ScaffoldMessenger.of(context).clearSnackBars();
                          },
                          child: Text(acceptLabel!),
                        ),

                  //* if [declineLabel] is not null then show decline button
                  declineLabel == null
                      ? const SizedBox(
                          height: 14,
                        )
                      : TextButton(
                          style: context.theme.textButtonTheme.style!.copyWith(
                            foregroundColor: const MaterialStatePropertyAll(
                                AppColors.kCanvasColor),
                          ),
                          onPressed: () {
                            _declineFunc();
                            ScaffoldMessenger.of(context).clearSnackBars();
                          },
                          child: Text(declineLabel!),
                        ),
                ],
              ),
            ),

            ///* [TimeBar] this will be shown on the @[Snack]'s bottom.
            /// It shows how much time left.

            TimerBar(
              duration: duration,
              disposeFunc: disposeFunction,
              isDeclined: getIsDeclined,
            ),
          ],
        );
    }
  }

  @override
  Color? get backgroundColor {
    switch (snackType) {
      case SnackType.warning:
        return AppColors.kRedCollor;

      default:
        return AppColors.kPrimary;
    }
  }

  @override
  Duration get duration {
    switch (snackType) {
      case SnackType.warning:
        return sDuration ?? const Duration(seconds: 5);

      default:
        return sDuration ?? const Duration(seconds: 10);
    }
  }

  @override
  EdgeInsetsGeometry? get padding => EdgeInsets.zero;
  @override
  DismissDirection get dismissDirection => DismissDirection.horizontal;
}
