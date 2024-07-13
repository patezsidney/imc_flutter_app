import 'package:flutter/material.dart';

class ImcItemDetail extends StatelessWidget {
  final String label;
  final String content;

  const ImcItemDetail({super.key, required this.content, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
