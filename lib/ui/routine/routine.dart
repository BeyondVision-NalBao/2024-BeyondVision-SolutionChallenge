import 'package:beyond_vision/provider/routine_provider.dart';
import 'package:beyond_vision/service/routine_service.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/routine/widgets/new_button.dart';
import 'package:beyond_vision/ui/routine/widgets/routine_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Routine extends StatelessWidget {
  const Routine({super.key});

  @override
  Widget build(BuildContext context) {
    RoutineProvider routineProvider = Provider.of<RoutineProvider>(context);
    RoutineService routineService = RoutineService();
    return Scaffold(
      appBar: MyAppBar(context, titleText: "운동 루틴"),
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: routineService.getAllRoutine(3),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              routineProvider.getRoutine(snapshot.data!);
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 그리드 열의 개수 설정
                    ),
                    itemCount:
                        routineProvider.routines.length + 1, // 요소 개수를 1만큼 늘림
                    itemBuilder: (context, index) {
                      if (index < routineProvider.routines.length) {
                        // 루틴 요소 표시
                        return RoutineButton(
                          routine: routineProvider.routines[index],
                          index: index,
                        );
                      } else {
                        // 마지막 요소로 NewButton 위젯 추가
                        return NewButton(
                          previousPage: true,
                        );
                      }
                    },
                  ),
                ),
              );
            } else {
              return NewButton(
                previousPage: true,
              );
            }
          }),
    );
  }
}
