import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class checkbox_or_text extends StatelessWidget {
  const checkbox_or_text({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
          visualDensity: const VisualDensity(horizontal: -4),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'I agree to ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                  text: 'privacyPolicy',
                  style: TextStyle(
                      color: isDark ? TColors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: isDark ? TColors.white : TColors.primary,
                      fontSize: 12)),
              TextSpan(
                text: ' and ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                  text: "TermsOfUse",
                  style: TextStyle(
                    color: isDark ? TColors.white : TColors.primary,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: isDark ? TColors.white : TColors.primary,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
