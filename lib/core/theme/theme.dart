import 'package:batechtask/core/theme/color_palete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData Darkmode(BuildContext context) {
    return ThemeData.dark().copyWith(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ColorPallete.dark_secondaryColor),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: ColorPallete.dark_textcolor),
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorPallete.dark_secondaryColor)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          filled: true,
          fillColor: ColorPallete.dark_Secondary_bgColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(ColorPallete.dark_secondaryColor))),
        textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 22, color: Colors.white),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
            bodySmall: TextStyle(fontSize: 12, color: Colors.white)));
  }
}
