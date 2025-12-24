import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class forms_fields extends StatelessWidget {
  const forms_fields({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.user),
                  labelText: "First Name",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black)),
            )),
            SizedBox(
              width: TSizes.spaceBtwInputFields(context) / 1.6,
            ),
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.user),
                  labelText: "Last Name",
                  labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black)),
            ))
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.user_edit,
              ),
              labelText: "UserName"),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.direct,
              ),
              labelText: "E-Mail"),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.call,
              ),
              labelText: "Phone Number"),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        ),
        TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.password_check,
              ),
              labelText: "Password",
              suffixIcon: Icon(Iconsax.password_check)),
        ),
        SizedBox(
          height: TSizes.spaceBtwInputFields(context),
        )
      ],
    ));
  }
}
