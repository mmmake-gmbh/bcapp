import 'dart:developer' as dev;
import 'dart:math';

import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_forecast_data.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PredictionChart extends StatefulWidget {
  final List<MensaForecastData> data;
  final int maxPrediction;
  final int currentOccupancy;
  final ScrollController sheetScrollController;

  const PredictionChart({
    super.key,
    required this.data,
    required this.maxPrediction,
    required this.currentOccupancy,
    required this.sheetScrollController,
  });

  @override
  State<PredictionChart> createState() => _PredictionChartState();
}

class _PredictionChartState extends State<PredictionChart> {
  late final ScrollController _scrollController;

  final double chartWidth = 930;
  late Locale? locale;

  double calculateScrollOffset(int position) {
    final offset = position * 25.0;

    return min(offset, chartWidth);
  }

  @override
  void initState() {
    final currentPosition = _getCurrentPosition();
    final initialOffset = calculateScrollOffset(currentPosition);
    dev.log("initialOffset: $initialOffset");
    _scrollController = ScrollController(initialScrollOffset: initialOffset);

    locale = context.read<UserViewModel>().locale;

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dev.log("chart, occupancy: ${widget.currentOccupancy}");

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 25,
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        controller: widget.sheetScrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                height: 8,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
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
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              controller: _scrollController,
              child: SizedBox(
                width: chartWidth,
                height: 180,
                child: BarChart(
                  BarChartData(
                    maxY: widget.maxPrediction.toDouble(),
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
                    barGroups: _prepareBarGroups(widget.data),
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
      ),
    );
  }

  bool _isCurrentGroup(int xPosition) {
    final now = DateTime.now();

    final firstDate = DateTime(now.year, now.month, now.day, 11, 30);
    final endDate = DateTime(now.year, now.month, now.day, 14, 30);
    final positionStartDate = firstDate.add(Duration(minutes: xPosition * 5));
    final positionEndDate = positionStartDate.add(const Duration(minutes: 5));

    return now.isAfter(positionStartDate) &&
        now.isBefore(positionEndDate) &&
        now.isBefore(endDate);
  }

  int _getCurrentPosition() {
    int position = 0;
    for (int i = 0; i < widget.data.length; i++) {
      if (_isCurrentGroup(i)) {
        position = i;
        break;
      }
    }

    return position;
  }

  BarChartGroupData _makeGroupData(int x, double yValue) {
    final isCurrentGroup = _isCurrentGroup(x);
    final stackItems = isCurrentGroup
        ? [
            BarChartRodStackItem(
                0, widget.currentOccupancy.toDouble(), const Color(0xFF11C1B0)),
            if (yValue > widget.currentOccupancy.toDouble())
              BarChartRodStackItem(widget.currentOccupancy.toDouble(), yValue,
                  const Color(0xFF60A9D6)),
          ]
        : [
            BarChartRodStackItem(widget.currentOccupancy.toDouble(), yValue,
                const Color(0xFF60A9D6)),
          ];

    if (isCurrentGroup) {
      dev.log('CurrentValue: $yValue');
    }

    return BarChartGroupData(
      barsSpace: 5,
      x: x,
      barRods: [
        BarChartRodData(
          toY: isCurrentGroup && widget.currentOccupancy > yValue
              ? widget.currentOccupancy.toDouble()
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

  String getFormattedDate(DateTime time) {
    final localizedText = DateFormat.jm().format(time);

    if (locale?.languageCode != "en") {
      return "$localizedText Uhr";
    }

    return localizedText;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      getFormattedDate(widget.data[value.toInt()].time.toLocal()),
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
      child: value % 3 == 0 ? text : const Text(""),
    );
  }
}
