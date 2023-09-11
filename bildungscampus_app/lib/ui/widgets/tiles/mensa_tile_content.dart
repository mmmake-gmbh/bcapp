import 'package:bildungscampus_app/core/models/mensa/meal.dart';
import 'package:bildungscampus_app/core/models/common/menu.dart';
import 'package:bildungscampus_app/core/utils/date_utils.dart' as utils;
import 'package:bildungscampus_app/ui/widgets/tiles/carousel_tile_content.dart';
import 'package:flutter/material.dart';

class MensaTileContent extends StatefulWidget {
  final List<Menu> weeklyMenu;
  final Color contentColor;
  final Color activeTabColor;
  final Color unselectedTabColor;

  const MensaTileContent({
    Key? key,
    required this.weeklyMenu,
    required this.contentColor,
    required this.activeTabColor,
    required this.unselectedTabColor,
  }) : super(key: key);

  @override
  State<MensaTileContent> createState() => _MensaTileContentState();
}

class _MensaTileContentState extends State<MensaTileContent>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: widget.weeklyMenu.length, vsync: this);
  }

  String _getDayName(BuildContext context, int dayOfTheWeek) {
    final currentLocale = Localizations.localeOf(context);
    final dateString =
        utils.DateUtils.getDateOfTheWeek(currentLocale, dayOfTheWeek);
    if (dateString.isEmpty) {
      return dateString;
    }

    return dateString.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.weeklyMenu.map((menu) {
              return CarouselTileContent<Meal>(
                items: menu.meals,
                contentColor: widget.contentColor,
                builder: (ctx, model) {
                  return Center(
                    child: Text(
                      model.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: widget.contentColor,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                onSlideTap: (ctx, model) {
                  // TODO: Mensa
                  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                    content: Text(model.name),
                  ));
                },
              );
            }).toList(),
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: widget.weeklyMenu.map((menu) {
            return Text(
              _getDayName(context, menu.dayOfTheWeek),
              style: const TextStyle(fontSize: 14.0),
            );
          }).toList(),
          indicator: const BoxDecoration(),
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.zero,
          labelColor: widget.activeTabColor,
          unselectedLabelColor: widget.unselectedTabColor,
        ),
      ],
    );
  }
}
