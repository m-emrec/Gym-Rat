import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color kButtonColor = Color(0xFF6C757D);
  static const Color kCanvasColor = Color(0xFFF8F9FA);
  static const Color kTextColor = Color(0xFF212529);
  static const Color kIconColor = Color(0xFF212529);
  static const Color kPrimary = Color(0xFFDEE2E6);

  static  Color kSignInPagebgColor = Color(0xFFF8F9FA).withOpacity(0.5);

}

class TextStyles {
  static final bodySmall = GoogleFonts.openSans(
    fontSize: 16,
    color: AppColors.kTextColor,
    fontWeight: FontWeight.w400
  );

  static final titleLarge = GoogleFonts.openSans(
    fontSize: 24,
    color: AppColors.kTextColor,
    fontWeight: FontWeight.bold,
  );

  static final subtitle = GoogleFonts.openSans(
    fontSize: 16,
    color: AppColors.kTextColor,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic
  );
  
  var a = Color.fromRGBO(95, 95, 95, 1);

}
