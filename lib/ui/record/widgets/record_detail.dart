import 'package:beyond_vision/ui/record/widgets/record_detail_info_box.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_text.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_title.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail_info_line.dart';

import 'package:flutter/material.dart';

class RecordDetail extends StatelessWidget {
  const RecordDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailTitle(title: "기록 요약"),
          DetailLine(),
          SizedBox(height: 10),
          DetailText(title: "운동 시간", text: "23분 02초"),
          DetailText(title: "소모 칼로리", text: "-"),
          SizedBox(height: 50),
          DetailTitle(title: "운동 기록"),
          DetailLine(),
          SizedBox(height: 10),
          DetailBox(title: "요가", time: "10분"),
          DetailBox(title: "근력", time: "5분 17초"),
          DetailBox(title: "체력", time: "7분 45초")
        ],
      ),
    );
  }
}
