import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  final String title;
  final String time;
  const DetailBox({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(boxColor),
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
              Text('${(int.parse(time) / 60).toStringAsFixed(1)}분',
                  style: const TextStyle(color: Colors.white, fontSize: 28)),
            ],
          ),
        ),
      ),
    );
  }
}
