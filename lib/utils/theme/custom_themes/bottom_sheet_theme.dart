import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TBottomSheetTheme {
  /// Light Mode

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      modalBackgroundColor: Colors.white,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));

  /// Dark Mode

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      modalBackgroundColor: TColors.dark,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
}
