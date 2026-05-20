import 'package:flutter/material.dart';

class ProfileMenueTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback ontab;

  const ProfileMenueTile({
    super.key,
    required this.ontab,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),

        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),

        IconButton(
          onPressed: ontab,
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 18,
          ),
        ),
      ],
    );
  }
}