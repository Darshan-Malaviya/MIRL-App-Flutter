import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';

enum TextFontType {
  labelSmall200,
  labelSmall300,
  labelSmall,
  labelSmall500,
  labelSmall600,
  labelMedium200,
  labelMedium300,
  labelMedium,
  labelMedium500,
  labelMedium600,
  labelLarge200,
  labelLarge300,
  labelLarge,
  labelLarge500,
  labelLarge600,
  bodySmall200,
  bodySmall300,
  bodySmall,
  bodySmall500,
  bodySmall600,
  bodyMedium200,
  bodyMedium300,
  bodyMedium,
  bodyMedium500,
  bodyMedium600,
  bodyLarge200,
  bodyLarge300,
  bodyLarge,
  bodyLarge500,
  bodyLarge600,
  titleSmall200,
  titleSmall300,
  titleSmall,
  titleSmall500,
  titleSmall600,
  titleMedium200,
  titleMedium300,
  titleMedium,
  titleMedium500,
  titleMedium600,
  titleLarge200,
  titleLarge300,
  titleLarge,
  titleLarge500,
  titleLarge600,
  headlineSmall200,
  headlineSmall300,
  headlineSmall,
  headlineSmall500,
  headlineSmall600,
  headlineMedium200,
  headlineMedium300,
  headlineMedium,
  headlineMedium500,
  headlineMedium600,
  headlineLarge200,
  headlineLarge300,
  headlineLarge,
  headlineLarge500,
  headlineLarge600,
  displaySmall200,
  displaySmall300,
  displaySmall,
  displaySmall500,
  displaySmall600,
  displayMedium200,
  displayMedium300,
  displayMedium,
  displayMedium500,
  displayMedium600,
  displayLarge200,
  displayLarge300,
  displayLarge,
  displayLarge500,
  displayLarge600,
}

extension on Text {
  Widget wrap({
    required BuildContext context,
    required String title,
    double? fontSize,
    Color? titleColor,
    TextAlign? titleTextAlign,
    int? maxLine,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool? softWrap,
    double? textScaleFactor,
    double? fontHeight,
    bool? isUnderline,
    double? lineHeight,
  }) {
    return Text(
      title,
      textScaleFactor: 1,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: titleColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: fontWeight ?? FontWeight.w600,
            decoration: isUnderline == true ? TextDecoration.underline : null,
            height: lineHeight,
          ),
      textAlign: titleTextAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// labelSmall - Font Size - 11
/// labelMedium - Font Size - 12
/// labelLarge - Font Size - 14

/// bodySmall - Font Size - 12
/// bodyMedium - Font Size - 14
/// bodyLarge - Font Size - 16

/// titleSmall - Font Size - 14
/// titleMedium - Font Size - 16
/// titleLarge - Font Size - 22

/// headlineSmall - Font Size - 24
/// headlineMedium - Font Size - 28
/// headlineLarge - Font Size - 32

/// displaySmall - Font Size - 36
/// displayMedium - Font Size - 45
/// displayLarge - Font Size - 57
