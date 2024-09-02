import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.green),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        textStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.green),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
  );
}