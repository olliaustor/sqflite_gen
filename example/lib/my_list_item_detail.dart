import 'package:flutter/material.dart';

class MyListItemDetail extends StatelessWidget {
  const MyListItemDetail({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          stepWidth: 90,
          child: Text(label),
        ),
        Text(text),
      ],
    );
  }
}
