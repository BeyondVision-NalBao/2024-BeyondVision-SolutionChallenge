import 'package:beyond_vision/core/constants.dart';
import 'package:flutter/material.dart';

class DetailLine extends StatelessWidget {
  const DetailLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(blurYellowColor),
            ),
          ),
        ),
      ),
    );
  }
}
