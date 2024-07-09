import 'package:bildungscampus_app/core/models/mensa/mensa_forecast_data.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/calendar_timeline.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/meals_list.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/prediction_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MensaContentWidget extends StatefulWidget {
  final int? initialIndex;

  const MensaContentWidget({super.key, required this.initialIndex});

  @override
  State<MensaContentWidget> createState() => _MensaContentWidgetState();
}

class _MensaContentWidgetState extends State<MensaContentWidget> {
  late PageController _pageController;
  late ItemScrollController _scrollController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialIndex ?? 0);
    _scrollController = ItemScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<MensaViewModel, List<DayPlan>?>(
          selector: (_, viewModel) => viewModel.mensaMenu?.tagesplan,
          builder: (context, dayPlans, _) => CalendarTimeline(
            dayPlans: dayPlans ?? [],
            controller: _scrollController,
            onClick: (idx) => _pageController.jumpToPage(idx),
          ),
        ),
        Expanded(
          child: Container(
              color: const Color(0xFFFAFAFA),
              padding: const EdgeInsets.only(
                  top: 16, left: 24, right: 24, bottom: 0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (idx) {
                  final viewModel = context.read<MensaViewModel>();

                  _scrollController.scrollTo(
                      index: idx, duration: const Duration(milliseconds: 200));
                  viewModel
                      .dayPlanSelected(viewModel.mensaMenu!.tagesplan[idx]);
                },
                children: context
                        .read<MensaViewModel>()
                        .mensaMenu
                        ?.tagesplan
                        .map(
                          (plan) => MealsList(
                            selectedDayPlan: plan,
                          ),
                        )
                        .toList() ??
                    [],
              )),
        ),
        SizedBox(
          height: 220,
          child: Selector<
              MensaViewModel,
              ({
                List<MensaForecastData> forecastData,
                int maxPrediction,
                int currentOccupancy
              })>(
            selector: (_, viewModel) => (
              forecastData: viewModel.forecast,
              maxPrediction: viewModel.maxforecast,
              currentOccupancy: viewModel.currentOccupancy,
            ),
            builder: (context, data, _) => PredictionChart(
              data: data.forecastData,
              maxPrediction: data.maxPrediction,
              currentOccupancy: data.currentOccupancy,
            ),
          ),
        ),
      ],
    );
  }
}
