import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/home/widgets/home_grid_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, titleText: " "),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('lib/config/assets/Logo.png'),
                ),
                Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'lib/config/assets/logoBlack.png')))),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.count(
              crossAxisCount: 2,
              children: const [
                HomeButton(name: "운동하기"),
                HomeButton(name: "운동 루틴"),
                HomeButton(name: "운동 기록"),
                HomeButton(name: "앱 설정")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
