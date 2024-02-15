import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextTileContent extends StatelessWidget {
  final String? text;
  final Color textColor;
  final double? textFontSize;
  final TextAlign textAlignment;
  final String? buttonText;
  final Color buttonTextColor;
  final Function? onTap;

  const TextTileContent({
    super.key,
    required this.text,
    required this.textColor,
    this.textFontSize,
    required this.textAlignment,
    required this.buttonText,
    required this.buttonTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text ?? '',
              textAlign: textAlignment,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: textColor,
                    fontSize: textFontSize,
                    letterSpacing: 0.09,
                    height: 1.33,
                  ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            height: 16.0,
            width: 16.0,
            child: IconButton(
              onPressed: onTap as void Function()?,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: SvgPicture.asset(
                SvgIcons.arrowRight,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                height: 16.0,
                width: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
