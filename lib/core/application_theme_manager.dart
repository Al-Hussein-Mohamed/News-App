import 'package:flutter/material.dart';
import 'package:news_app/configuration/color_palette.dart';

class ApplicationThemeManager {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Exo",
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 25,
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
        fontSize: 25,
        fontWeight: FontWeight.normal,
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