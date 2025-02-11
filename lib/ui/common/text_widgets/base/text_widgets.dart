import 'package:flutter/material.dart';

// labelSmall - Font Size - 11
// labelMedium - Font Size - 12
// labelLarge - Font Size - 14
// bodySmall - Font Size - 12
// bodyMedium - Font Size - 14
// bodyLarge - Font Size - 16
// titleSmall - Font Size - 14
// titleMedium - Font Size - 16
// titleLarge - Font Size - 22
// headlineSmall - Font Size - 24
// headlineMedium - Font Size - 28
// headlineLarge - Font Size - 32
// displaySmall - Font Size - 36
// displayMedium - Font Size - 45
// displayLarge - Font Size - 57

/// labelSmall - Font Size - 11
class LabelSmallText extends StatelessWidget {
  const LabelSmallText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.fontFamily,
      this.isUnderline = false,
      this.shadow})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;
  final String? fontFamily;
  final List<Shadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: titleColor ?? Theme.of(context).textTheme.labelSmall?.color,
          fontWeight: fontWeight,
          decoration: isUnderline == true ? TextDecoration.underline : null,
          height: lineHeight,
          fontSize: fontSize,
          shadows: shadow,
          letterSpacing: -0.1,
          fontFamily: fontFamily),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// labelMedium - Font Size - 12
class LabelMediumText extends StatelessWidget {
  const LabelMediumText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.labelMedium?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// labelLarge - Font Size - 14
class LabelLargeText extends StatelessWidget {
  const LabelLargeText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.labelLarge?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// bodySmall - Font Size - 12
class BodySmallText extends StatelessWidget {
  const BodySmallText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.fontFamily,
      this.lineHeight,
      this.shadows,
      this.isUnderline = false,
      this.letterSpacing})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final String? fontFamily;
  final double? lineHeight;
  final List<Shadow>? shadows;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.bodySmall?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
            fontFamily: fontFamily,
            shadows: shadows ?? null,
            fontSize: fontSize,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// bodyMedium - Font Size - 14
class BodyMediumText extends StatelessWidget {
  const BodyMediumText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.fontFamily,
      this.shadows,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;
  final String? fontFamily;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.bodyMedium?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            fontSize: fontSize,
            letterSpacing: -0.1,
            fontFamily: fontFamily,
            shadows: shadows ?? null,
            fontStyle: fontStyle,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// bodyLarge - Font Size - 16
class BodyLargeText extends StatelessWidget {
  const BodyLargeText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.fontFamily,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
            fontFamily: fontFamily,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// titleSmall - Font Size - 14
class TitleSmallText extends StatelessWidget {
  const TitleSmallText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.fontFamily,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final String? fontFamily;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: titleColor ?? Theme.of(context).textTheme.titleSmall?.color,
          fontWeight: fontWeight,
          decoration: isUnderline == true ? TextDecoration.underline : null,
          height: lineHeight,
          fontFamily: fontFamily,
          letterSpacing: -0.1,
          fontSize: fontSize),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// titleMedium - Font Size - 16
class TitleMediumText extends StatelessWidget {
  const TitleMediumText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.fontFamily,
      this.isUnderline = false,
      this.shadows})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;
  final String? fontFamily;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.titleMedium?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            fontFamily: fontFamily,
            letterSpacing: -0.1,
            fontSize: fontSize,
            shadows: shadows,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// titleLarge - Font Size - 22
class TitleLargeText extends StatelessWidget {
  const TitleLargeText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.fontFamily,
      this.isUnderline = false,this.shadow,})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final String? fontFamily;
  final double? lineHeight;
  final List<Shadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
            fontFamily: fontFamily,
            fontSize: fontSize,
          shadows: shadow
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// headlineSmall - Font Size - 24
class HeadlineSmallText extends StatelessWidget {
  const HeadlineSmallText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false,
      this.shadow})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;
  final List<Shadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.headlineSmall?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
            shadows: shadow,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// headlineMedium - Font Size - 28
class HeadlineMediumText extends StatelessWidget {
  const HeadlineMediumText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.fontFamily,
      this.isUnderline = false,
      this.shadow})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;
  final String? fontFamily;
  final List<Shadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.headlineMedium?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            fontFamily: fontFamily,
            letterSpacing: -0.1,
            shadows: shadow,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// headlineLarge - Font Size - 32
class HeadlineLargeText extends StatelessWidget {
  const HeadlineLargeText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.headlineLarge?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// displaySmall - Font Size - 36
class DisplaySmallText extends StatelessWidget {
  const DisplaySmallText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.displaySmall?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// displayMedium - Font Size - 45
class DisplayMediumText extends StatelessWidget {
  const DisplayMediumText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.displayMedium?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}

/// displayLarge - Font Size - 57
class DisplayLargeText extends StatelessWidget {
  const DisplayLargeText(
      {Key? key,
      required this.title,
      this.titleColor,
      this.titleTextAlign = TextAlign.left,
      this.maxLine,
      this.fontWeight,
      this.softWrap,
      this.fontStyle,
      this.textScaleFactor,
      this.fontSize,
      this.fontHeight,
      this.lineHeight,
      this.isUnderline = false})
      : super(key: key);

  final String title;
  final double? fontSize;
  final Color? titleColor;
  final TextAlign titleTextAlign;
  final int? maxLine;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final bool? softWrap;
  final double? textScaleFactor;
  final double? fontHeight;
  final bool? isUnderline;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaler: TextScaler.linear(1),
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.displayLarge?.color,
            fontWeight: fontWeight,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
            letterSpacing: -0.1,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap,
    );
  }
}
