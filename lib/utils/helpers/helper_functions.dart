import 'package:flutter/material.dart';
class THelperFunction{
  static void showSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  static Color? getColor(String value) {
    // Map for color matching
    final colorMap = {
      "Green": Colors.green,
      "Red": Colors.red,
      "Blue": Colors.blue,
      "Pink": Colors.pink,
      "Grey": Colors.grey,
      "Purple": Colors.purple,
      "Black": Colors.black,
      "White": Colors.white,
      "Yellow": Colors.yellow,
      "Orange": Colors.orange,
      "DeepOrange": Colors.deepOrange,
      "Brown": Colors.brown,
      "Teal": Colors.teal,
      "Indigo": Colors.indigo,
    };

    // Return matched color or null if not found
    return colorMap[value];
  }
  static void showAlert(BuildContext context,String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context,Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }

  static double ScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double ScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isDrak(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }


}