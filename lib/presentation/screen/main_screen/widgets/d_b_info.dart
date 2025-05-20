import 'package:flutter/material.dart';

class DBInfo extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String timeInfo;

  const DBInfo({
    required this.onPressed,
    required this.title,
    required this.timeInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(title),
        ),
        const SizedBox(width: 10),
        Text(timeInfo),
        const SizedBox(width: 10),
      ],
    );
  }
}
