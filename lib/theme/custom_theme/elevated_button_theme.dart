import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      // side: const BorderSide(color: Colors.grey),
      padding: const EdgeInsets.symmetric(vertical: 15),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    )
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        // side: const BorderSide(color: Colors.grey),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
  );
}