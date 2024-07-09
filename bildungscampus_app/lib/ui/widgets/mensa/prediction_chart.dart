import 'dart:developer';

import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_forecast_data.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PredictionChart extends StatelessWidget {
  final List<MensaForecastData> data;
  final int maxPrediction;
  final int currentOccupancy;

  const PredictionChart({
    super.key,
    required this.data,
    required this.maxPrediction,
    required this.currentOccupancy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 15,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).mensa_view_forecast_title,
                  style: const TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontSize: 16,
                    fontFamily: 'DIN OT',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text("Powered by",
                            style: TextStyle(
                              color: Color(0xFF3B3B3B),
                              fontSize: 12,
                              fontFamily: 'DIN OT',
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        AppImages.logoFraunhofer,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BarChart(
                BarChartData(
                  maxY: maxPrediction.toDouble(),
                  barTouchData: BarTouchData(enabled: false),
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
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: const AxisTitles()),
                  borderData: FlBorderData(
                    show: false,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                  barGroups: _prepareBarGroups(data),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 0.2,
                    checkToShowHorizontalLine: (value) => value <= 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        dashArray: [1, 24],
                        color: Colors.black.withOpacity(0.3),
                        strokeWidth: 4,
                      );
                    },
                  ),
                  groupsSpace: 4,
                  alignment: BarChartAlignment.start,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool _isCurrentGroup(int xPosition) {
    final now = DateTime.now();

    final firstDate = DateTime(now.year, now.month, now.day, 11, 30);
    final endDate = DateTime(now.year, now.month, now.day, 14, 30);
    final positionStartDate = firstDate.add(Duration(minutes: xPosition * 15));
    final positionEndDate = positionStartDate.add(const Duration(minutes: 15));

    return now.isAfter(positionStartDate) &&
        now.isBefore(positionEndDate) &&
        now.isBefore(endDate);
  }

  BarChartGroupData _makeGroupData(int x, double yValue) {
    final isCurrentGroup = _isCurrentGroup(x);
    log("x: $x, y: $yValue, currentOccupancy: $currentOccupancy, isCurrentGroup: $isCurrentGroup");
    final stackItems = isCurrentGroup
        ? [
            BarChartRodStackItem(
                0, currentOccupancy.toDouble(), const Color(0xFF11C1B0)),
            if (yValue > currentOccupancy.toDouble())
              BarChartRodStackItem(
                  currentOccupancy.toDouble(), yValue, const Color(0xFF60A9D6)),
          ]
        : [
            BarChartRodStackItem(
                currentOccupancy.toDouble(), yValue, const Color(0xFF60A9D6)),
          ];

    return BarChartGroupData(
      barsSpace: 5,
      x: x,
      barRods: [
        BarChartRodData(
          toY: isCurrentGroup && currentOccupancy > yValue
              ? currentOccupancy.toDouble()
              : yValue,
          width: 21,
          color: const Color(0xFF60A9D6),
          rodStackItems: stackItems,
        ),
      ],
    );
  }

  List<BarChartGroupData> _prepareBarGroups(List<MensaForecastData> data) {
    final items = data
        .asMap()
        .entries
        .map((entry) =>
            _makeGroupData(entry.key, entry.value.prediction.toDouble()))
        .toList();

    return items;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      '11:30',
      '11:45',
      '12:00',
      '12:15',
      '12:30',
      '12:45',
      '13:00',
      '13:15',
      '13:30',
      '13:45',
      '14:00',
      '14:15',
      '14:30'
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
      space: 4, //margin top
      child: value % 4 == 0 ? text : const Text(""),
    );
  }
}
