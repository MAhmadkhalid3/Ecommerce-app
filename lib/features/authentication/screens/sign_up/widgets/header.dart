import 'package:flutter/material.dart';

class Header_text extends StatelessWidget {
  const Header_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Lets create your account",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}