import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/workout/widgets/workout_detail_box.dart';
import 'package:flutter/material.dart';
import 'package:beyond_vision/service/workout_service.dart';

class Categories extends StatelessWidget {
  final int cate;
  final String name;
  final bool? isRoutine;

  const Categories({
    super.key,
    required this.cate,
    required this.name,
    this.isRoutine,
  });

  @override
  Widget build(BuildContext context) {
    WorkOutService workOutService = WorkOutService();

    return Scaffold(
      appBar: MyAppBar(context, titleText: name),
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: workOutService.getAllWorkOut(cate),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return WorkOutDetail(
                        workout: snapshot.data![index],
                        isRoutine: isRoutine,
                      );
                    }),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
