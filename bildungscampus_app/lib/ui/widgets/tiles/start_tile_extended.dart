import 'package:auto_size_text/auto_size_text.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/common/conditional_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';

class StartTileExtended extends StatelessWidget {
  final TileType? tileType;
  final String? tileTitle;
  final Color titleColor;
  final Widget child;
  final Color backgroundColor;
  final String? navigationPath;
  final bool isFullTileTap;
  final int maxTitleLines;

  StartTileExtended({
    this.tileType,
    this.tileTitle,
    required this.titleColor,
    required this.child,
    required this.backgroundColor,
    this.navigationPath = "",
    required this.isFullTileTap,
    required this.maxTitleLines,
  });

  StartTileExtended.withBaseModel(
    BaseStartTileViewModel model, {
    Key? key,
    Color contentColor = Colors.white,
    required Color bgColor,
    required this.isFullTileTap,
    required this.child,
  })  : tileType = model.type,
        tileTitle = model.title,
        titleColor = contentColor,
        backgroundColor = bgColor,
        navigationPath = model.navigationPath,
        maxTitleLines = model.maxTitleLines;

  void _onTap(BuildContext context) {
    if (navigationPath!.isNotEmpty) {
      Navigator.pushNamed(context, navigationPath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: SvgPicture.asset(
                  SvgIcons.arrowRight,
                  colorFilter:
                      ColorFilter.mode(this.titleColor, BlendMode.srcIn),
                  height: 13.0,
                  width: 12.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: AutoSizeText(
                    tileTitle ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: this.titleColor, letterSpacing: 0.09),
                    maxLines: maxTitleLines,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Card(
            color: backgroundColor,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: ConditionalInkWell(
                condition: isFullTileTap,
                onTap: () => _onTap(context),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
