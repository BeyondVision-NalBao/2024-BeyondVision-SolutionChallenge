import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/speaker.dart';
import 'package:flutter/material.dart';

AppBar MyAppBar(BuildContext context, {String? titleText}) {
  return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 70,
      leadingWidth: 350,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          titleText!,
          style: const TextStyle(
              color: Color(fontYellowColor),
              fontSize: 40,
              fontWeight: FontWeight.w900),
        ),
      ),
      actions: [
        IconButton(
          icon:
              const Icon(speakerIcon, color: Color(fontYellowColor), size: 50),
          onPressed: () {
            // 아이콘을 눌렀을 때 수행할 동작
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Speaker()));
          },
        ),
      ]);
}
