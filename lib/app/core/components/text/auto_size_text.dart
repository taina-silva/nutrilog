import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

enum TextType { nano, small, medium, large }

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextType textType;
  final FontWeight fWeight;
  final Color color;
  final int? maxLines;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final TextDecoration textDecoration;
  final FontStyle? fontStyle;

  const AdaptiveText({
    super.key,
    required this.text,
    required this.textType,
    this.fWeight = FWeight.regular,
    this.color = CColors.neutral900,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.visible,
    this.textDecoration = TextDecoration.none,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    double getTextScaleFactor() {
      switch (textType) {
        case TextType.nano:
          return 1;
        case TextType.small:
          return 1.2;
        case TextType.medium:
          return 1.5;
        case TextType.large:
          return 2;
      }
    }

    int getMaxLines() {
      switch (textType) {
        case TextType.nano:
          return 1;
        case TextType.small:
          return 2;
        case TextType.medium:
          return 3;
        case TextType.large:
          return 4;
      }
    }

    return AutoSizeText(
      text,
      textScaleFactor: getTextScaleFactor(),
      maxLines: maxLines ?? getMaxLines(),
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fWeight,
        color: color,
        fontStyle: fontStyle,
        decoration: textDecoration,
      ),
      softWrap: true,
      overflow: textOverflow,
    );
  }
}
