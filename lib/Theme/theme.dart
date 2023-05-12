import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    fontStyle: FontStyle.italic);

var a = Color.fromRGBO(95, 95, 95, 1);

ThemeData lightTheme = ThemeData(
  primaryColor: kPrimary,
  canvasColor: kCanvasColor,
  dividerColor: kTextColor,
  textTheme: TextTheme(
    bodySmall: bodySmall,
    titleLarge: titleLarge,
    displaySmall: subtitle,
  ),
  brightness: Brightness.light,
  // input decoration
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

  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
      backgroundColor: kPrimary,
      
  ),

  dividerTheme: const DividerThemeData(color: kTextColor),
);
