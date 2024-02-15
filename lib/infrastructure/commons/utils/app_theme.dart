import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

import '../../../ui/common/range_slider/thumb_shape.dart';

class AppTheme {
  static ThemeData setTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        fontFamily: FontWeightEnum.w700.toInter,
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
        sliderTheme: SliderThemeData(
          trackHeight: 10,
          rangeTrackShape: RectangularRangeSliderTrackShape(),
        ),
        menuTheme: MenuThemeData(
          style: MenuStyle(
            backgroundColor: MaterialStateProperty.all(ColorConstants.whiteColor),
            side: MaterialStateProperty.all(BorderSide(color: ColorConstants.dropDownBorderColor)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            elevation: MaterialStateProperty.all(1),
            visualDensity: VisualDensity.standard,
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isCollapsed: true,
          isDense: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          fillColor: ColorConstants.whiteColor,
          filled: true,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w600.toInter,
                overflow: TextOverflow.ellipsis,
              ),
          errorStyle: TextStyle(color: ColorConstants.secondaryColor, fontSize: 12, fontFamily: FontWeightEnum.w600.toInter),
          enabledBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.dropDownBorderColor),
              borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
            ),
            shadow: BoxShadow(color: ColorConstants.primaryColor.withOpacity(0.0), blurRadius: 6, offset: const Offset(0, 0)),
          ),
          focusedBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.bottomTextColor),
              borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
            ),
            shadow: BoxShadow(color: ColorConstants.primaryColor.withOpacity(0.0), blurRadius: 6, offset: const Offset(0, 0)),
          ),
          errorBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.secondaryColor),
              borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
            ),
            shadow: BoxShadow(color: ColorConstants.primaryColor.withOpacity(0.0), blurRadius: 6, offset: const Offset(0, 0)),
          ),
          focusedErrorBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.secondaryColor),
              borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
            ),
            shadow: BoxShadow(color: ColorConstants.primaryColor.withOpacity(0.0), blurRadius: 6, offset: const Offset(0, 0)),
          ),
          errorMaxLines: 3,
        ));
  }
}
