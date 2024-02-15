import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/calendar_timeline.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/meals_list.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/mensa_info_dialog_content.dart';
//import 'package:bildungscampus_app/ui/widgets/mensa/prediction_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MensaView extends StatefulWidget {
  const MensaView({super.key});

  @override
  State<MensaView> createState() => _MensaViewState();
}

class _MensaViewState extends State<MensaView> {
  late final Future<void> Function() loadFuture;

  @override
  void initState() {
    super.initState();

    loadFuture = context.read<MensaViewModel>().load;
  }

  @override
  Widget build(BuildContext context) {
    final titleList =
        context.read<AppViewModel>().getAppMenuTitle(FeatureType.mensa);

    final locale = context.select((UserViewModel model) => model.locale);
    var title = LocalizedTextUtils.getLocalizedText(titleList, locale);
    if (title.isEmpty) {
      title = S.of(context).mensa_view_title_backup;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B78A7),
        title: Transform.translate(
          offset: const Offset(0, -2),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final appBarHeight = AppBar().preferredSize.height;
              showDialog(
                context: context,
                builder: (context) => Dialog.fullscreen(
                  child: MensaInfoDialogContent(
                    appBarHeight: appBarHeight,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          )
        ],
        titleSpacing: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: null,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: loadFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FeatureView(
            featureType: FeatureType.mensa,
            children: [
              Column(
                children: [
                  Selector<MensaViewModel, List<DayPlan>?>(
                    selector: (_, viewModel) => viewModel.mensa?.tagesplan,
                    builder: (context, dayPlans, _) =>
                        CalendarTimeline(dayPlans: dayPlans ?? []),
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFFFAFAFA),
                      padding: const EdgeInsets.only(
                          top: 16, left: 24, right: 24, bottom: 0),
                      child: Selector<MensaViewModel, DayPlan?>(
                        selector: (_, viewModel) => viewModel.selectedDayPlan,
                        builder: (context, selectedDayPlan, _) {
                          if (selectedDayPlan == null) {
                            return const SizedBox.shrink();
                          }
                          if (selectedDayPlan.isDisabled(DateTime.now())) {
                            if (!selectedDayPlan.datum
                                .isBefore(DateTime.now())) {
                              return SafeArea(
                                child: Center(
                                  child: Text(
                                    S.of(context).mensa_view_closed_text,
                                    style: const TextStyle(
                                      color: Color(0xFF979797),
                                      fontSize: 16,
                                      fontFamily: 'DIN OT',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return SafeArea(
                              child: Center(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: S
                                            .of(context)
                                            .mensa_view_in_the_past_label_part1,
                                        style: const TextStyle(
                                          color: Color(0xFF979797),
                                          fontSize: 16,
                                          fontFamily: 'DIN OT',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: S
                                            .of(context)
                                            .mensa_view_in_the_past_label_part2,
                                        style: const TextStyle(
                                          color: Color(0xFF979797),
                                          fontSize: 16,
                                          fontFamily: 'DIN OT',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          return MealsList(
                            selectedDayPlan: selectedDayPlan,
                          );
                        },
                      ),
                    ),
                  ),
                  /*SizedBox(
                    height: 150,
                    child: PredictionChart(),
                  ),*/
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
