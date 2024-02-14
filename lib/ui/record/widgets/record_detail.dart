import 'package:beyond_vision/ui/record/widgets/record_detail_info_box.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_text.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_title.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_line.dart';
import 'package:beyond_vision/provider/date_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RecordDetail extends StatelessWidget {
  const RecordDetail({super.key});

  @override
  Widget build(BuildContext context) {
    DateProvider provider = Provider.of<DateProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailTitle(title: "기록 요약"),
          const DetailLine(),
          const SizedBox(height: 10),
          const DetailText(title: "운동 시간", text: "20분"),
          const DetailText(title: "소모 칼로리", text: "-"),
          const SizedBox(height: 50),
          const DetailTitle(title: "운동 기록"),
          const DetailLine(),
          const SizedBox(height: 10),
          DetailBox(title: "요가", time: provider.todayExerciseTime.toString()),
          DetailBox(title: "근력", time: provider.todayExerciseTime.toString()),
          DetailBox(title: "체력", time: provider.todayExerciseTime.toString())
        ],
      ),
    );
  }
}
