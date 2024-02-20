import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ActivateYourMirlConnectCodeWidget extends ConsumerStatefulWidget {
  const ActivateYourMirlConnectCodeWidget({super.key});

  @override
  ConsumerState<ActivateYourMirlConnectCodeWidget> createState() => _ActivateYourMirlConnectCodeWidgetState();
}

class _ActivateYourMirlConnectCodeWidgetState extends ConsumerState<ActivateYourMirlConnectCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        12.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.share.tr(),
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 5,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.blackColor,
        ),
        20.0.spaceY,
        TitleSmallText(
          fontFamily: FontWeightEnum.w600.toInter,
          title: LocaleKeys.moreYouInvite.tr(),
          titleColor: ColorConstants.blackColor,
          maxLine: 2,
        ),
        20.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.primaryColor,
          title: LocaleKeys.activateMirlConnectCode.tr(),
          titleColor: ColorConstants.textColor,
          onPressed: () {},
          //  onPressed: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen),
        ),
        20.0.spaceY,
        TitleSmallText(
          fontFamily: FontWeightEnum.w400.toInter,
          title: LocaleKeys.turnConnections.tr(),
          titleColor: ColorConstants.blackColor,
          titleTextAlign: TextAlign.center,
          maxLine: 10,
        ),
        40.0.spaceY,
        LabelSmallText(
          title: LocaleKeys.inaugural.tr(),
          titleColor: ColorConstants.primaryColor,
          titleTextAlign: TextAlign.center,
          maxLine: 2,
          fontSize: 10,
        ),
      ],
    );
  }
}
