import 'package:auto_size_text/auto_size_text.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/common/conditional_inkwell.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/text_tile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';

class StartTile extends StatelessWidget {
  final TileType? tileType;
  final String? tileTitle;
  final String? iconPath;
  final Color titleColor;
  final Widget child;
  final bool showHeader;
  final Color backgroundColor;
  final String? navigationPath;
  final bool isFullTileTap;
  final int maxTitleLines;
  final Function? onTap;

  StartTile({
    this.tileType,
    this.tileTitle,
    this.iconPath,
    required this.titleColor,
    required this.child,
    required this.backgroundColor,
    this.showHeader = true,
    this.navigationPath = "",
    required this.isFullTileTap,
    required this.maxTitleLines,
    this.onTap,
  });

  StartTile.withBaseModel(
    BaseStartTileViewModel model, {
    Key? key,
    Color contentColor = Colors.white,
    required Color bgColor,
    this.showHeader = true,
    required this.isFullTileTap,
    required this.child,
    this.onTap,
  })  : tileType = model.type,
        tileTitle = model.title,
        iconPath = model.iconPath,
        titleColor = contentColor,
        backgroundColor = bgColor,
        navigationPath = model.navigationPath,
        maxTitleLines = model.maxTitleLines;

  StartTile.withTextContent(
    TextTileViewModel model, {
    Key? key,
    Color contentColor = Colors.white,
    required Color bgColor,
    this.showHeader = true,
    required this.isFullTileTap,
    this.onTap,
  })  : tileType = model.type,
        tileTitle = model.title,
        iconPath = model.iconPath,
        titleColor = contentColor,
        backgroundColor = bgColor,
        navigationPath = model.navigationPath,
        maxTitleLines = model.maxTitleLines,
        child = TextTileContent(
          text: model.description,
          textColor: contentColor,
          buttonText: model.buttonText,
          buttonTextColor: contentColor,
          textAlignment: TextAlign.center,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Container(
        padding: tileType == TileType.Small
            ? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10)
            : const EdgeInsets.all(8),
        width: double.infinity,
        child: ConditionalInkWell(
          condition: isFullTileTap,
          onTap: onTap as void Function()?,
          child: Column(
            children: [
              if (showHeader)
                ConditionalInkWell(
                  condition: !isFullTileTap,
                  onTap: onTap as void Function()?,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        SvgIcons.arrowRight,
                        colorFilter:
                            ColorFilter.mode(this.titleColor, BlendMode.srcIn),
                        height: 13.0,
                        width: 12.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: AutoSizeText(
                            tileTitle ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: this.titleColor,
                                  height: 1.2,
                                  letterSpacing: 0.1,
                                ),
                            maxLines: maxTitleLines,
                          ),
                        ),
                      ),
                      if (iconPath?.isNotEmpty ?? false)
                        SvgPicture.asset(
                          iconPath!,
                          height: 22.0,
                          width: 22.0,
                          colorFilter: ColorFilter.mode(
                              this.titleColor, BlendMode.srcIn),
                        )
                    ],
                  ),
                ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
