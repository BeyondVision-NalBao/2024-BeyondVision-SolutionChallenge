import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/home/widgets/home_grid_button.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(speakerIcon, color: Color(fontYellowColor), size: 50),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: GridView.count(
                crossAxisCount: 2,
                children: const [HomeButton(name: "앱 설정")],
              ),
            ),
          ],
        ));
  }
}
