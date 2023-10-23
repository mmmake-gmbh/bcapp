import 'package:auto_size_text/auto_size_text.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/common/conditional_inkwell.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/text_tile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bildungscampus_app/core/enums/tile_type.dart';

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
  final EdgeInsetsGeometry? padding;

  const StartTile({
    Key? key,
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
    this.padding,
    this.onTap,
  }) : super(key: key);

  StartTile.withBaseModel(
    BaseStartTileViewModel model, {
    Key? key,
    Color contentColor = Colors.white,
    required Locale? locale,
    required Color bgColor,
    this.showHeader = true,
    required this.isFullTileTap,
    required this.child,
    this.padding,
    this.onTap,
  })  : tileType = model.type,
        tileTitle = LocalizedTextUtils.getLocalizedText(model.title, locale),
        iconPath = model.iconPath,
        titleColor = contentColor,
        backgroundColor = bgColor,
        navigationPath = model.navigationPath,
        maxTitleLines = model.maxTitleLines,
        super(key: key);

  StartTile.withTextContent(
    TextTileViewModel model, {
    Key? key,
    Color contentColor = Colors.white,
    required Locale? locale,
    required Color bgColor,
    this.showHeader = true,
    required this.isFullTileTap,
    this.padding,
    this.onTap,
  })  : tileType = model.type,
        tileTitle = LocalizedTextUtils.getLocalizedText(model.title, locale),
        iconPath = model.iconPath,
        titleColor = contentColor,
        backgroundColor = bgColor,
        navigationPath = model.navigationPath,
        maxTitleLines = model.maxTitleLines,
        child = TextTileContent(
          text: LocalizedTextUtils.getLocalizedText(model.description, locale),
          textColor: contentColor,
          buttonText: model.buttonText,
          buttonTextColor: contentColor,
          textAlignment: TextAlign.center,
          onTap: onTap,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: backgroundColor,
      child: Container(
        padding: padding ??
            const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 12),
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
                      if (iconPath?.isNotEmpty ?? false)
                        Transform.translate(
                          offset: const Offset(0, 6),
                          child: SvgPicture.asset(
                            iconPath!,
                            height: 16.0,
                            width: 16.0,
                            colorFilter: ColorFilter.mode(
                              titleColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: AutoSizeText(
                            tileTitle ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontFamily: 'DINOT Bold',
                                  color: titleColor,
                                  height: 1.5,
                                ),
                            maxLines: maxTitleLines,
                          ),
                        ),
                      ),
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
