import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/calendar_timeline.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/meals_list.dart';
//import 'package:bildungscampus_app/ui/widgets/mensa/prediction_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MensaContent extends StatefulWidget {
  final int? initialIndex;

  const MensaContent({super.key, required this.initialIndex});

  @override
  State<MensaContent> createState() => _MensaContentState();
}

class _MensaContentState extends State<MensaContent> {
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
          selector: (_, viewModel) => viewModel.mensa?.tagesplan,
          builder: (context, dayPlans, _) => CalendarTimeline(
            dayPlans: dayPlans ?? [],
            controller: _scrollController,
            onClick: (idx) => _pageController.animateToPage(idx,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn),
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
                  viewModel.dayPlanSelected(viewModel.mensa!.tagesplan[idx]);
                },
                children: context
                        .read<MensaViewModel>()
                        .mensa
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
        /*SizedBox(
          height: 150,
          child: PredictionChart(),
        ),*/
      ],
    );
  }
}
