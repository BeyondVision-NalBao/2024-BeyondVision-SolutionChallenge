import 'package:beyond_vision/provider/date_provider.dart';
import 'package:beyond_vision/service/record_service.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/record/widgets/record_calendar.dart';
import 'package:beyond_vision/ui/record/widgets/record_detail.dart';
import 'package:beyond_vision/ui/record/widgets/record_graph_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    DateProvider provider = Provider.of<DateProvider>(context);
    RecordService recordService = RecordService();

    return Scaffold(
        appBar: MyAppBar(context, titleText: "운동 기록"),
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: recordService.getAllRecord(3),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                provider.getRecord(snapshot.data!);
                return Column(
                  children: [
                    Calendar(provider: provider),
                    SizedBox(
                      height: 550,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                  height: 250,
                                  child: GraphSlider(provider: provider)),
                              RecordDetail(provider: provider)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "아직 기록이 없습니다.",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                );
              }
            }));
  }
}
