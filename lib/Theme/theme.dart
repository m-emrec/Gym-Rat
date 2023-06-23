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
final labelMedium = GoogleFonts.openSans(
  fontSize: 14,
  color: kButtonColor,
);

// var a = Color.fromRGBO(95, 95, 95, 1);

class AppTheme {
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
        elevation: 2,
      ),

      /// Text Theme
      textTheme: TextTheme(
        bodySmall: bodySmall,
        titleLarge: titleLarge,
        displaySmall: subtitle,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
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
      dropdownMenuTheme: const DropdownMenuThemeData(menuStyle: MenuStyle()),

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

      ///* PopUp Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.kPrimary,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.kCanvasColor,
        dayBackgroundColor: const MaterialStatePropertyAll(AppColors.kPrimary),
        dayOverlayColor: const MaterialStatePropertyAll(AppColors.kButtonColor),
        dayStyle: labelLarge,
        headerBackgroundColor: AppColors.kButtonColor,
        headerForegroundColor: AppColors.kCanvasColor,
        todayForegroundColor:
            const MaterialStatePropertyAll(AppColors.kButtonColor),
        todayBackgroundColor:
            const MaterialStatePropertyAll(AppColors.kCanvasColor),
        yearBackgroundColor: const MaterialStatePropertyAll(AppColors.kPrimary),
        yearForegroundColor:
            const MaterialStatePropertyAll(AppColors.kTextColor),
        yearOverlayColor:
            const MaterialStatePropertyAll(AppColors.kButtonColor),
        yearStyle: labelLarge,
      )

      ////
      );

  //*/ Dark Theme
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  //// end of class
}
