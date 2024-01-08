import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class AppTheme {
  static ThemeData setTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontWeightEnum.w400.toInter,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorSchemeSeed: ColorConstants.primaryColor,
      scaffoldBackgroundColor: ColorConstants.whiteColor,
      appBarTheme: AppBarTheme(color: ColorConstants.primaryColor, elevation: 0, scrolledUnderElevation: 0),
      dividerColor: ColorConstants.greyLightColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorConstants.primaryColor,
        selectionColor: ColorConstants.primaryColor.withOpacity(0.4),
        selectionHandleColor: ColorConstants.primaryColor,
      ),
    );
  }
}
