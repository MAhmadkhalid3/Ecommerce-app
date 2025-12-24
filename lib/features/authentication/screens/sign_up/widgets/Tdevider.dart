import 'package:flutter/material.dart';
class TDevider extends StatelessWidget {
  const TDevider({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
              color: isDark
                  ? Colors.grey.shade700
                  : Colors.grey.shade300,
              thickness: 0.5,
              indent: 6,
              endIndent: 16,
            )),
        Text(
          "Or Sign Up with",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
            child: Divider(
              color: isDark
                  ? Colors.grey.shade700
                  : Colors.grey.shade300,
              thickness: 0.5,
              indent: 16,
              endIndent: 6,
            )),
      ],
    );
  }
}