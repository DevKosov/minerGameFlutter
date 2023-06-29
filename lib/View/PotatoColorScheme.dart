import 'package:flutter/material.dart';

const potatoColors = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 13, 59, 102),
  onPrimary: Colors.white,
  secondary: Colors.green,
  onSecondary: Colors.black,
  error: Colors.red,
  onError: Colors.red,
  background: Color.fromARGB(255, 251, 246, 239),
  onBackground: Color.fromARGB(255, 13, 59, 102),
  surface: Colors.white,
  onSurface: Colors.black,
);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
    textStyle: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    ),
  ),
);

final minerButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    fixedSize: const Size(50, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Add border radius
    ),
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);
