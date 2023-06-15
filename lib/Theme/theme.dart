import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_rat_v2/constants.dart';

const Color kButtonColor = Color(0xFF6C757D);
const Color kCanvasColor = Color(0xFFF8F9FA);
const Color kTextColor = Color(0xFF212529);
const Color kIconColor = Color(0xFF212529);
const Color kPrimary = Color(0xFFDEE2E6);

final Color kSignInPagebgColor = const Color(0xFFF8F9FA).withOpacity(0.5);

final bodySmall = GoogleFonts.openSans(
    fontSize: 16, color: kTextColor, fontWeight: FontWeight.w400);

final titleLarge = GoogleFonts.openSans(
  fontSize: 24,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

final subtitle = GoogleFonts.openSans(
  fontSize: 16,
  color: kTextColor,
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.italic,
);
final labelLarge = GoogleFonts.openSans(
  fontSize: 12,
  color: kButtonColor,
  fontWeight: FontWeight.bold,
);

// var a = Color.fromRGBO(95, 95, 95, 1);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimary,
  canvasColor: kCanvasColor,
  focusColor: kTextColor,

  /// Button Themes
  buttonTheme: const ButtonThemeData(),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(kButtonColor),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(bodySmall.color!),
      iconColor: MaterialStateProperty.all<Color>(bodySmall.color!),
      fixedSize:
          MaterialStateProperty.all(const Size.fromWidth(double.maxFinite)),
    ),
  ),
  ////

  /// App bar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: kCanvasColor,
    // shape: Border(
    //   bottom: BorderSide(
    //     color: kPrimary,
    //     width: 2.5,
    //   ),
    // ),
    elevation: 2,
  ),

  /// Text Theme
  textTheme: TextTheme(
    bodySmall: bodySmall,
    titleLarge: titleLarge,
    displaySmall: subtitle,
    labelLarge: labelLarge,
  ),

  /// input decoration
  inputDecorationTheme: InputDecorationTheme(
    //Borders
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(5),
    ),

    // Label Style
    errorStyle: TextStyle(
      fontSize: 12,
      color: Colors.red.shade900,
      fontWeight: FontWeight.w500,
    ),
    labelStyle: const TextStyle(color: kTextColor),
    floatingLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: kTextColor,
    ),
  ),

  /// Snackbar theme
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: kPrimary,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(menuStyle: const MenuStyle()),

  ///Divder Theme
  dividerTheme: const DividerThemeData(color: kTextColor),
  // Progress Indicator Theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.kButtonColor,
    circularTrackColor: AppColors.kPrimary,
  ),

  /// Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.kPrimary,
    elevation: 1,
    deleteIconColor: AppColors.kButtonColor,
    labelStyle: labelLarge.copyWith(color: AppColors.kTextColor),
  ),

  ////
);
