import 'package:flutter/material.dart';

class TNavigatorBarTheme {
  static NavigationBarThemeData darkNavigatorBarTheme = NavigationBarThemeData(
      backgroundColor: const Color(0xFF272727),
      indicatorColor: Colors.white.withOpacity(0.1),
      iconTheme:
          WidgetStateProperty.all(const IconThemeData(color: Colors.white)),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(color: Colors.white),
      ));

  static NavigationBarThemeData lightNavigatorBarTheme = NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: Colors.black.withOpacity(0.1),
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Colors.black),
      ),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(color: Colors.black),
      ));
}
