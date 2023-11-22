import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:bildungscampus_app/ui/widgets/common/tile_button.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/widgets/parking/parking_listview_item.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParkingView extends StatefulWidget {
  final ParkingLotCategory? preselectedCategory;

  const ParkingView({super.key, this.preselectedCategory});

  @override
  State<ParkingView> createState() => _ParkingViewState();
}

class _ParkingViewState extends State<ParkingView>
    with SingleTickerProviderStateMixin {
  final double tilesHeight = 116;
  final double tilesSpacing = 8;
  late TabController _tabController;

  Widget getTilesRow() {
    return Row(
      children: [
        Expanded(
          child: TileButton(
            contentColor: Colors.white,
            bgColor: AppColors.primaryOneColor,
            title: S.of(context).parking_view_tiles_timetable_title,
            height: tilesHeight,
            svgIcon: SvgIcons.bus,
            onTap: (ctx) {
              Navigator.of(context).pushNamed(AppRouter.timetableRoute);
            },
          ),
        ),
        SizedBox(width: tilesSpacing),
        Expanded(
          child: TileButton(
            contentColor: Colors.white,
            bgColor: AppColors.primaryOneColor,
            title: S.of(context).parking_view_tiles_campus_rad_title,
            titleIcon: SvgIcons.externalLink,
            height: tilesHeight,
            svgIcon: SvgIcons.bike,
            onTap: (ctx) {
              final url = context.read<AppViewModel>().campusRadLink;
              if (url != null) {
                launchUrlString(url);
              }
            },
          ),
        ),
        SizedBox(width: tilesSpacing),
        Expanded(
          child: TileButton(
            contentColor: Colors.white,
            bgColor: AppColors.primaryOneColor,
            title: S.of(context).parking_view_tiles_zaeg_title,
            titleIcon: SvgIcons.externalLink,
            height: tilesHeight,
            svgIcon: SvgIcons.eCar,
            onTap: (ctx) {
              final url = context.read<AppViewModel>().zaegLink;
              if (url != null) {
                launchUrlString(url);
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    var initialIndex = 0;

    if (widget.preselectedCategory != null) {
      initialIndex = widget.preselectedCategory == ParkingLotCategory.students
          ? 0
          : (widget.preselectedCategory == ParkingLotCategory.staff ? 1 : 2);
    }

    _tabController =
        TabController(length: 3, vsync: this, initialIndex: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final titleList =
        context.read<AppViewModel>().getAppMenuTitle(FeatureType.parking);

    final locale = context.select((UserViewModel model) => model.locale);
    var title = LocalizedTextUtils.getLocalizedText(titleList, locale);
    if (title.isEmpty) {
      title = S.of(context).parking_view_title_backup;
    }

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: ReusableAppBars.standardAppBar(context, title),
          drawer: const AppDrawer(),
          body: FeatureView(
            featureType: FeatureType.parking,
            children: [
              Column(
                children: [
                  Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.parkingViewBorderColor,
                                width: 2.0),
                          ),
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        labelPadding: const EdgeInsets.all(0),
                        labelColor: const Color.fromRGBO(0, 0, 0, 0.87),
                        labelStyle: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'DINOT Medium',
                        ),
                        indicatorColor: AppColors.primaryTwoColor,
                        unselectedLabelColor:
                            const Color.fromRGBO(0, 0, 0, 0.54),
                        tabs: [
                          Tab(
                            text: S
                                .of(context)
                                .parking_view_categories_students
                                .toUpperCase(),
                          ),
                          Tab(
                            text: S
                                .of(context)
                                .parking_view_categories_staff
                                .toUpperCase(),
                          ),
                          Tab(
                            text: S
                                .of(context)
                                .parking_view_categories_guests
                                .toUpperCase(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      width: double.infinity,
                      color: AppColors.parkingViewBackgroundColor,
                      child: Column(
                        children: [
                          Consumer<AppViewModel>(
                            builder: (context, model, child) {
                              if (model.isBusy) {
                                return const Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    createParkingTabListView(
                                        model, ParkingLotCategory.students),
                                    createParkingTabListView(
                                        model, ParkingLotCategory.staff),
                                    createParkingTabListView(
                                        model, ParkingLotCategory.guests),
                                  ],
                                ),
                              );
                            },
                          ),
                          getTilesRow()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget createParkingTabListView(
    AppViewModel model,
    ParkingLotCategory category,
  ) {
    return RefreshIndicator(
      onRefresh: () => context.read<AppViewModel>().updateSilently(context),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final currentModel = model.getParkingLotsByCategory(category)[index];
          return ChangeNotifierProvider.value(
            value: currentModel,
            child: ParkingListViewItem(category: category),
          );
        },
        itemCount: model.getParkingLotsByCategory(category).length,
      ),
    );
  }
}
