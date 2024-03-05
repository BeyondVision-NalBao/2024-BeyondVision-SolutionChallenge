import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final String title;
  final String text;
  const DetailText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 28)),
        ],
      ),
    );
  }
}
