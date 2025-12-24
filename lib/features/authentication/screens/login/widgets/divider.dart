import 'package:flutter/material.dart';

import '../../../../../utils/helpers/helper_functions.dart';
class TDivider extends StatelessWidget {
  const TDivider({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDrak(context);
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
          "Or Sign In with",
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