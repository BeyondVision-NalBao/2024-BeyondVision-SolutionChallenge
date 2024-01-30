import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final String title;
  const DetailTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Color(fontYellowColor),
            fontSize: 40,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
