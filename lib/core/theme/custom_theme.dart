import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/app_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return _lightTheme;
  }

  static final ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen, brightness: Brightness.light),
    fontFamily: "Manrope",
    primaryColorLight: green,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: green, // Change primary color to green
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        green,
      ),
    )),
    expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(), backgroundColor: Colors.white),
  );
}

const primaryColor = Color.fromARGB(255, 1, 1, 1);
const blueAccent = Color(0xff264653);
const green = Color(0xff2A9D8F); // Custom green color
const orangeAccent = Color(0xffF4A261);
const redAccent = Color(0xffE76F51);
