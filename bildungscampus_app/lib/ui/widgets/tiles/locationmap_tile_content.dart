import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationMapTileContent extends StatelessWidget {
  final String? text;
  final Color textColor;
  final double? textFontSize;
  final TextAlign textAlignment;
  final String? buttonText;
  final Color buttonTextColor;
  final Function? onTap;

  LocationMapTileContent({
    required this.text,
    required this.textColor,
    this.textFontSize,
    required this.textAlignment,
    required this.buttonText,
    required this.buttonTextColor,
    this.onTap,
  });

  LocationMapTileContent.withModel(
    TextTileViewModel model, {
    required Color contentColor,
    this.textFontSize = 16.0,
    this.textAlignment = TextAlign.left,
    this.onTap,
  })  : text = model.description,
        buttonText = model.buttonText,
        textColor = contentColor,
        buttonTextColor = contentColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      color: textColor,
                      height: 38,
                      width: 38,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          SvgIcons.map,
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        text ?? '',
                        textAlign: textAlignment,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: textColor, fontSize: textFontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ButtonTheme(
            minWidth: 0,
            height: 0,
            child: TextButton(
              onPressed: onTap as void Function()?,
              child: Text(
                buttonText!,
                style: TextStyle(
                  color: buttonTextColor,
                ),
                textAlign: TextAlign.right,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(top: 10, left: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
