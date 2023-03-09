import 'package:flutter/material.dart';

class TextTileContent extends StatelessWidget {
  final String? text;
  final Color textColor;
  final double? textFontSize;
  final TextAlign textAlignment;
  final String? buttonText;
  final Color buttonTextColor;
  final Function? onTap;

  const TextTileContent({
    Key? key,
    required this.text,
    required this.textColor,
    this.textFontSize,
    required this.textAlignment,
    required this.buttonText,
    required this.buttonTextColor,
    this.onTap,
  }) : super(key: key);

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
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: textColor,
                    fontSize: textFontSize,
                    letterSpacing: 0.09,
                    height: 1.1875,
                  ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ButtonTheme(
            minWidth: 0,
            height: 0,
            child: TextButton(
              onPressed: onTap as void Function()?,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(top: 10, left: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                buttonText!,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: buttonTextColor,
                      height: 1.2,
                      letterSpacing: 0.1,
                    ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
