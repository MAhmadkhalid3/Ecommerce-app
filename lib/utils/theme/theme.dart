import 'package:ecommerce/utils/theme/custom_themes/chip_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/app_bar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/check_box_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/navigatorBarTheme.dart';
import 'custom_themes/outline_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class TAppTheme {
  /// --- Light Theme
  static ThemeData LightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
      chipTheme: TChipTheme.lightChipTheme,
      outlinedButtonTheme: TOOutlinedButtonTheme.LightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      navigationBarTheme: TNavigatorBarTheme.lightNavigatorBarTheme);

  /// --- Dark Theme
  static ThemeData DarkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: " Poppins",
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFF272727),
      textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
      chipTheme: TChipTheme.darkChipTheme,
      outlinedButtonTheme: TOOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      navigationBarTheme: TNavigatorBarTheme.darkNavigatorBarTheme);
}
