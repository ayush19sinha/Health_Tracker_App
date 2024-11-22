import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static const Color primaryColor = Color(0xFFD5D2CE);
  static const Color accentColor = Colors.red;
  static const Color backgroundColor = Colors.white;
  static const Color textColorPrimary = Colors.black87;
  static const Color textColorSecondary = Colors.black54;

  static ThemeData get lightTheme {
    return ThemeData(

      primarySwatch: Colors.red,
      hintColor: const Color(0xFFE3D4D8),
      visualDensity: VisualDensity.adaptivePlatformDensity,

      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: GoogleFonts.poppins(color: textColorPrimary),
        bodyMedium: GoogleFonts.poppins(color: textColorSecondary),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.primaryColor,
      ),
      cardTheme: CardTheme(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),


      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: textColorSecondary),
        fillColor: backgroundColor.withOpacity(0.8),
        filled: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: GoogleFonts.poppins(
          color: Colors.red,
          fontSize: 12,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textColorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: GoogleFonts.poppins(color: textColorPrimary),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
      ),
    );
  }



  static TextStyle formInputTextStyle = TextStyle(
    color: textColorPrimary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle formLabelTextStyle = TextStyle(
    color: textColorSecondary,
  );
}