import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/timeline_element.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarTimeline extends StatelessWidget {
  final ItemScrollController controller;
  final List<DayPlan> dayPlans;
  final Function(int) onClick;

  const CalendarTimeline(
      {super.key,
      required this.controller,
      required this.dayPlans,
      required this.onClick});

  final Color _disabledTextColor = const Color(0xFF979797);
  final Color _mainTextColor = const Color(0xFF193E69);

  @override
  Widget build(BuildContext context) {
    final initialIndex = context.select<MensaViewModel, int?>(
        (viewModel) => viewModel.initialDayPlanIndex);

    return SizedBox(
      height: 104,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 12, left: 12, right: 12),
        child: Column(
          children: [
            Expanded(
              child: ScrollablePositionedList.builder(
                itemScrollController: controller,
                initialScrollIndex: initialIndex ?? 0,
                scrollDirection: Axis.horizontal,
                itemCount: dayPlans.length,
                itemBuilder: (context, idx) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SizedBox(
                    height: 44,
                    width: 44,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<MensaViewModel>()
                            .dayPlanSelected(dayPlans[idx]);
                        onClick(idx);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEEE')
                                .format(dayPlans[idx].datum)
                                .characters
                                .first,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: dayPlans[idx].isDisabled(DateTime.now())
                                  ? _disabledTextColor
                                  : _mainTextColor,
                              fontSize: 12,
                              fontFamily: 'DIN OT',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Selector<MensaViewModel, DayPlan?>(
                            selector: (_, viewModel) =>
                                viewModel.selectedDayPlan,
                            builder: (context, selectedDayPlan, _) =>
                                TimelineElement(
                              textColor:
                                  dayPlans[idx].isDisabled(DateTime.now())
                                      ? _disabledTextColor
                                      : _mainTextColor,
                              dayPlan: dayPlans[idx],
                              selectedDayPlan: selectedDayPlan,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Selector<MensaViewModel, DayPlan?>(
              selector: (_, viewModel) => viewModel.selectedDayPlan,
              builder: (context, selectedDayPlan, _) {
                if (selectedDayPlan == null) {
                  return const SizedBox.shrink();
                }
                return Text(
                  '${S.of(context).mensa_view_timeline_menu_label} – ${DateFormat("EEEE d. MMMM yyyy").format(selectedDayPlan.datum)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5400000214576721),
                    fontSize: 14,
                    fontFamily: 'DIN OT',
                    fontWeight: FontWeight.w300,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
