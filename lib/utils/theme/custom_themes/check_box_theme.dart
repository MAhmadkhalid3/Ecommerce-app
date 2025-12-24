import 'package:flutter/material.dart';

class TCheckBoxTheme {
  /// Light Mode
  static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white; // ✅ Selected state ka color
          } else {
            return Colors.transparent; // ✅ Unselected state ka color
          }
        },
      ),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue;
          } else {
            return Colors.transparent;
          }
        },
      ));

  /// Dark Mode
  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black; // ✅ Selected state ka color
          } else {
            return Colors.transparent; // ✅ Unselected state ka color
          }
        },
      ),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue;
          } else {
            return Colors.transparent;
          }
        },
      ));
}
