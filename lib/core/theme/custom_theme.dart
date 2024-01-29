import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return _lightTheme;
  }

  static final ThemeData _lightTheme = ThemeData(
    fontFamily: "Montserrat",
    scaffoldBackgroundColor: Colors.white,
    primaryColor:blueAccent ,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        redAccent,
      ),
    )),
    expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(), backgroundColor: Colors.white),
  );
}

const primaryColor = Color.fromARGB(255, 1, 1, 1);
const blueAccent = Color(0xff264653);
const green = Color(0xff2A9D8F);
const orangeAccent = Color(0xffF4A261);
const redAccent = Color(0xffE76F51);
