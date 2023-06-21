import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/utils/shared/timer.dart';

enum SnackType {
  error,
  danger,
  warning,
  primary,
  widget,
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

  /// The text that will be written on the snackbar body.
  final String label;

  /// Can be [Null].
  ///   This will used as [declineButton]'s label.
  final String? declineLabel;

  /// Can be [Null]
  ///   This will used as [acceptButton]'s label.
  final String? acceptLabel;

  ///
  final BuildContext context;

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
    ///* if the the [acceptLabel] is not null but [acceptFunc] is null then throw an error.
    // assert(acceptLabel != null && acceptFunc != null,
    //     "acceptLAbel is not null but acceptFunc is null.\nYou have to provide acceptFunc");

    switch (snackType) {
      /// if the [SnackType] is widget the return content which is givn to the @[Snack].
      case SnackType.widget:
        return super.content;

      /// By Default return a Text, button and timer,
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///* Body of the snackbar.
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

                  ///* if [acceptLabel] is not null then show accept button
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

                  ///* if [declineLabel] is not null then show decline button
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

            ///* [TimeBar] this will be shown on the @[Snack]'s top.
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
        return sDuration ?? const Duration(seconds: 10);

      default:
        return sDuration ?? const Duration(seconds: 10);
    }
  }

  @override
  EdgeInsetsGeometry? get padding => EdgeInsets.zero;
  @override
  DismissDirection get dismissDirection => DismissDirection.horizontal;

  @override
  State<Snack> createState() => _SnackState();
}

class _SnackState extends State<Snack> {
  @override
  void initState() {
    logger.d("message");
    super.initState();
  }

  @override
  void dispose() {
    logger.i("asdasdasdasdasd");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Build");
    return Snack(
        context: context, content: widget.content, label: widget.label);
  }
}

// class a implements SnackBar {
//   @override
//   // TODO: implement action
//   SnackBarAction? get action => throw UnimplementedError();

//   @override
//   // TODO: implement actionOverflowThreshold
//   double? get actionOverflowThreshold => throw UnimplementedError();

//   @override
//   // TODO: implement animation
//   Animation<double>? get animation => throw UnimplementedError();

//   @override
//   // TODO: implement backgroundColor
//   Color? get backgroundColor => throw UnimplementedError();

//   @override
//   // TODO: implement behavior
//   SnackBarBehavior? get behavior => throw UnimplementedError();

//   @override
//   // TODO: implement clipBehavior
//   Clip get clipBehavior => throw UnimplementedError();

//   @override
//   // TODO: implement closeIconColor
//   Color? get closeIconColor => throw UnimplementedError();

//   @override
//   // TODO: implement content
//   Widget get content => throw UnimplementedError();

//   @override
//   StatefulElement createElement() {
//     // TODO: implement createElement
//     throw UnimplementedError();
//   }

//   @override
//   State<SnackBar> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }

//   @override
//   List<DiagnosticsNode> debugDescribeChildren() {
//     // TODO: implement debugDescribeChildren
//     throw UnimplementedError();
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     // TODO: implement debugFillProperties
//   }

//   @override
//   // TODO: implement dismissDirection
//   DismissDirection get dismissDirection => throw UnimplementedError();

//   @override
//   // TODO: implement duration
//   Duration get duration => throw UnimplementedError();

//   @override
//   // TODO: implement elevation
//   double? get elevation => throw UnimplementedError();

//   @override
//   // TODO: implement key
//   Key? get key => throw UnimplementedError();

//   @override
//   // TODO: implement margin
//   EdgeInsetsGeometry? get margin => throw UnimplementedError();

//   @override
//   // TODO: implement onVisible
//   VoidCallback? get onVisible => throw UnimplementedError();

//   @override
//   // TODO: implement padding
//   EdgeInsetsGeometry? get padding => throw UnimplementedError();

//   @override
//   // TODO: implement shape
//   ShapeBorder? get shape => throw UnimplementedError();

//   @override
//   // TODO: implement showCloseIcon
//   bool? get showCloseIcon => throw UnimplementedError();

//   @override
//   DiagnosticsNode toDiagnosticsNode(
//       {String? name, DiagnosticsTreeStyle? style}) {
//     // TODO: implement toDiagnosticsNode
//     throw UnimplementedError();
//   }

//   @override
//   String toStringDeep(
//       {String prefixLineOne = '',
//       String? prefixOtherLines,
//       DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
//     // TODO: implement toStringDeep
//     throw UnimplementedError();
//   }

//   @override
//   String toStringShallow(
//       {String joiner = ', ',
//       DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
//     // TODO: implement toStringShallow
//     throw UnimplementedError();
//   }

//   @override
//   String toStringShort() {
//     // TODO: implement toStringShort
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement width
//   double? get width => throw UnimplementedError();

//   @override
//   SnackBar withAnimation(Animation<double> newAnimation, {Key? fallbackKey}) {
//     // TODO: implement withAnimation
//     throw UnimplementedError();
//   }
// }
