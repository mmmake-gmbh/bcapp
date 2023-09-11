import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TextWithHyphenation extends StatelessWidget {
  const TextWithHyphenation(
    this.data, {
    Key? key,
    this.style,
  }) : super(key: key);

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final String text = data;
      final span = TextSpan(text: text, style: style);
      final textPainter = TextPainter(
          text: span, maxLines: 2, textDirection: ui.TextDirection.ltr)
        ..layout(maxWidth: size.maxWidth);

      final TextSelection selection =
          TextSelection(baseOffset: 0, extentOffset: text.length);
      final List<TextBox> boxes = textPainter.getBoxesForSelection(selection);
      final int lines = boxes.length;
      if (lines > 1) {
        // The text has more than a line
        return Text(text.replaceFirst('\u00ad', '\u00ad-'), style: style);
      } else {
        return Text(text, style: style);
      }
    });
  }
}
