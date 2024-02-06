import 'dart:ui';
import 'package:beyond_vision/core/constants.dart';

import 'package:flutter/material.dart';

class WorkOutDetail extends StatelessWidget {
  final String name;
  const WorkOutDetail({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: const Color(boxColor),
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(children: [
            SizedBox(
              width: 200,
              height: 50,
              child: Text(name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
      ),
    );
  }
}
