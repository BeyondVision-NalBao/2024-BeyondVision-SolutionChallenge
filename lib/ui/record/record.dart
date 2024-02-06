import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/record/widgets/record_calendar.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail.dart';
import 'package:beyond_vision/ui/record/widgets/record_graph_slider.dart';
import 'package:flutter/material.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context, titleText: "운동 기록"),
        backgroundColor: Colors.black,
        body: const Column(
          children: [
            Calendar(),
            SizedBox(
              height: 550,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 250, child: GraphSlider()),
                      RecordDetail()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
