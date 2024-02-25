import 'package:beyond_vision/model/record_model.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_box.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_text.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_title.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_line.dart';
import 'package:beyond_vision/provider/date_provider.dart';
import 'package:flutter/material.dart';

class RecordDetail extends StatelessWidget {
  final DateProvider provider;
  const RecordDetail({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    List<Widget> todays = provider.todayRecords
        .map((value) => DetailBox(
            title: value.exerciseName!, time: value.exerciseTime!.toString()))
        .toList();
    List<Widget> children = [
      const DetailTitle(title: "기록 요약"),
      const DetailLine(),
      const SizedBox(height: 10),
      DetailText(
          title: "운동 시간(분)", text: provider.todayExerciseTime.toString()),
      const DetailText(title: "소모 칼로리", text: "-"),
      const SizedBox(height: 50),
      const DetailTitle(title: "운동 기록"),
      const DetailLine(),
      const SizedBox(height: 10),
    ];
    children.addAll(todays);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
