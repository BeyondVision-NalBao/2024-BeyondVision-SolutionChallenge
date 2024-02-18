import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_camera_view.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_routine_detail_box.dart';
import 'package:flutter/material.dart';

class RoutineDetail extends StatefulWidget {
  const RoutineDetail({super.key});

  @override
  State<RoutineDetail> createState() => _RoutineDetailState();
}

class _RoutineDetailState extends State<RoutineDetail> {
  bool isChanged = false;
  final List<List<String>> _items = [
    ['스쿼트', '30회'],
    ['런지', '30회'],
    ['사이드런지', '30회']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: MyAppBar(context, titleText: "매일 저녁"),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(
                children: _items.asMap().entries.map((entry) {
                  int index = entry.key;
                  List<String> item = entry.value;
                  return DetailBox(
                      key: ValueKey(index),
                      index: index,
                      title: item[0],
                      time: item[1]);
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Material(
                shape: const CircleBorder(side: BorderSide.none),
                elevation: 15,
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(boxColor),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CameraView()));
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 80,
                          color: Color(fontYellowColor),
                        ))),
              ),
            )
          ]),
        ));
  }
}
