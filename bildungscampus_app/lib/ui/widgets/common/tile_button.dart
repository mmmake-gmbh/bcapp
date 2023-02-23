import 'package:bildungscampus_app/ui/widgets/common/text_with_hyphenation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';

class TileButton extends StatelessWidget {
  final String title;
  final Color contentColor;
  final String? svgIcon;
  final String? titleIcon;
  final double height;
  final double width;
  final Color bgColor;
  final Function(BuildContext context)? onTap;

  TileButton({
    required this.title,
    required this.contentColor,
    this.svgIcon,
    this.titleIcon,
    this.height = 100,
    this.width = 100,
    this.bgColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(context);
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(12),
        color: bgColor,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: SvgPicture.asset(
                    titleIcon != null ? titleIcon! : SvgIcons.arrowRight,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 12.0,
                    width: 12.0,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: TextWithHyphenation(
                      title,
                      style: TextStyle(
                        color: contentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (svgIcon?.isNotEmpty ?? false)
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset(
                  svgIcon!,
                  colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
                  height: 25,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
