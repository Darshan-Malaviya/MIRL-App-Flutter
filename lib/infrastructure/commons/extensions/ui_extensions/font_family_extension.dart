import 'package:mirl/infrastructure/commons/constants/font_constants.dart';

enum FontWeightEnum { w100, w200, w300, w400, w500, w600, w700, w800, w900 }

extension SetFontWeight on FontWeightEnum {
  String get toInter {
    return switch (this) {
      FontWeightEnum.w100 => FontConstant.interThin,
      FontWeightEnum.w200 => FontConstant.interExtraLight,
      FontWeightEnum.w300 => FontConstant.interLight,
      FontWeightEnum.w400 => FontConstant.interRegular,
      FontWeightEnum.w500 => FontConstant.interMedium,
      FontWeightEnum.w600 => FontConstant.interSemiBold,
      FontWeightEnum.w700 => FontConstant.interBold,
      FontWeightEnum.w800 => FontConstant.interExtraBold,
      FontWeightEnum.w900 => FontConstant.interBlack,
    };
  }
}
