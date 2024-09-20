import 'package:flutter/material.dart';
import 'package:news_app/core/config/color_palette.dart';

class ApplicationThemeManager {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Exo",
    scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme.light(
        primary: Colors.black,  // Primary color for dialogs, buttons, etc.
        onPrimary: Colors.white, // Text color on top of primary color
        secondary: Colors.white,  // Secondary color for FAB, etc.
        onSecondary: Colors.black, // Text color on top of secondary color
        surface: Colors.white, // Background color of cards, dialogs, etc.
        onSurface: Colors.black, // Text color on surfaces
        error: Colors.red,  // Color for errors
        onError: Colors.white, // Text color on error backgrounds
      ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.normal,
      ),
      backgroundColor: ColorPalette.primaryColor,
      toolbarHeight: 90,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
      ),
      iconTheme: const IconThemeData(size: 40, color: Colors.white)
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    )
  );
}