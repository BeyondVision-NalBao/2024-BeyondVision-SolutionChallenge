import 'package:beyond_vision/core/constants.dart';
import 'package:beyond_vision/provider/date_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RecordBar extends StatefulWidget {
  final DateProvider provider;
  const RecordBar({super.key, required this.provider});

  final Color barColor = Colors.white;
  final Color touchedBarColor = const Color(fontYellowColor);

  @override
  State<StatefulWidget> createState() => RecordBarState();
}

class RecordBarState extends State<RecordBar> {
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: AspectRatio(
        aspectRatio: 2,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 199,
                    child: BarChart(
                      mainBarData(widget.provider),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isSelected = false,
    Color? barColor,
    double width = 22,
  }) {
    barColor ??= widget.barColor;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y == 0
              ? 0
              : y > 30
                  ? 30
                  : y,
          color: isSelected ? widget.touchedBarColor : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.black,
          ),
        ),
      ],
      showingTooltipIndicators: isSelected ? [0] : [],
    );
  }

  List<BarChartGroupData> showingGroups(DateProvider provider) {
    int selectedIndex = provider.selectedIndex;
    return List.generate(7, (i) {
      switch (i) {
        case 0:
          return makeGroupData(0, provider.thisWeekExerciseTime[0],
              isSelected: i == selectedIndex);
        case 1:
          return makeGroupData(1, provider.thisWeekExerciseTime[1],
              isSelected: i == selectedIndex);
        case 2:
          return makeGroupData(2, provider.thisWeekExerciseTime[2],
              isSelected: i == selectedIndex);
        case 3:
          return makeGroupData(3, provider.thisWeekExerciseTime[3],
              isSelected: i == selectedIndex);
        case 4:
          return makeGroupData(4, provider.thisWeekExerciseTime[4],
              isSelected: i == selectedIndex);
        case 5:
          return makeGroupData(5, provider.thisWeekExerciseTime[5],
              isSelected: i == selectedIndex);
        case 6:
          return makeGroupData(6, provider.thisWeekExerciseTime[6],
              isSelected: i == selectedIndex);
        default:
          return throw Error();
      }
    });
  }

  BarChartData mainBarData(DateProvider provider) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipMargin: -5,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return provider.todayExerciseTime > 30
                ? null
                : BarTooltipItem(
                    (rod.toY).toString(),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ));
          },
        ),
      ),
      titlesData: const FlTitlesData(
        show: false,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 10,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(provider),
      gridData: const FlGridData(show: false),
    );
  }

  // Widget getTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Colors.white,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 14,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 0:
  //       text = const Text('M', style: style);
  //       break;
  //     case 1:
  //       text = const Text('T', style: style);
  //       break;
  //     case 2:
  //       text = const Text('W', style: style);
  //       break;
  //     case 3:
  //       text = const Text('T', style: style);
  //       break;
  //     case 4:
  //       text = const Text('F', style: style);
  //       break;
  //     case 5:
  //       text = const Text('S', style: style);
  //       break;
  //     case 6:
  //       text = const Text('S', style: style);
  //       break;
  //     default:
  //       text = const Text('', style: style);
  //       break;
  //   }
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 16,
  //     child: text,
  //   );
  // }
}
