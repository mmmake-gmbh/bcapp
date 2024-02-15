import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PredictionChart extends StatefulWidget {
  const PredictionChart({super.key});

  @override
  State<PredictionChart> createState() => _PredictionChartState();
}

class _PredictionChartState extends State<PredictionChart> {
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(0, [5]);
    final barGroup2 = makeGroupData(1, [16]);
    final barGroup3 = makeGroupData(2, [18]);
    final barGroup4 = makeGroupData(3, [20]);
    final barGroup5 = makeGroupData(4, [17]);
    final barGroup6 = makeGroupData(5, [19]);
    final barGroup7 = makeGroupData(6, [20]);
    final barGroup8 = makeGroupData(7, [15]);
    final barGroup9 = makeGroupData(8, [13]);
    final barGroup10 = makeGroupData(9, [8]);
    final barGroup11 = makeGroupData(10, [8]);
    final barGroup12 = makeGroupData(11, [6]);
    final barGroup13 = makeGroupData(12, [4]);
    final barGroup14 = makeGroupData(13, [2]);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
      barGroup13,
      barGroup14,
    ];

    showingBarGroups = items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 24),
          child: Text(
            "Mensa Auslastung",
            style: TextStyle(
              color: Color(0xFF3B3B3B),
              fontSize: 16,
              fontFamily: 'DIN OT',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: BarChart(
            BarChartData(
              maxY: 20,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.grey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${group.x}',
                        const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    }),
              ),
              titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles:
                      const AxisTitles() /*AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  interval: 1,
                                  getTitlesWidget: leftTitles,
                                ),
                              ),*/
                  ),
              borderData: FlBorderData(
                show: false,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
              barGroups: showingBarGroups,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 0.01,
                checkToShowHorizontalLine: (value) => value <= 0.01,
                getDrawingHorizontalLine: (value) {
                  log("value: $value");
                  return FlLine(
                    dashArray: [1, 17],
                    color: Colors.black.withOpacity(0.3),
                    strokeWidth: 3,
                  );
                },
              ),
              groupsSpace: 3,
              alignment: BarChartAlignment.center,
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, List<double> yList) {
    return BarChartGroupData(
      //showingTooltipIndicators: x == 5 ? [0] : [],
      barsSpace: 3,
      x: x,
      barRods: yList
          .map(
            (y1) => BarChartRodData(
              toY: y1,
              color: const Color(0xCC60A9D6),
              width: 15,
            ),
          )
          .toList(),
    );
  }

/*
  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }*/
  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22'
    ];

    final Widget text = Text(
      "${titles[value.toInt()]} Uhr",
      style: const TextStyle(
        color: Color(0xFF3B3B3B),
        fontSize: 12,
        fontFamily: 'DIN OT',
        fontWeight: FontWeight.w500,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0, //margin top
      child: value % 4 == 0 ? text : const Text(""),
    );
  }
}
