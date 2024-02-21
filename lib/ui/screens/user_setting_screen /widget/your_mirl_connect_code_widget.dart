import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class YourMirlConnectCodeWidget extends ConsumerStatefulWidget {
  const YourMirlConnectCodeWidget({super.key});

  @override
  ConsumerState<YourMirlConnectCodeWidget> createState() => _YourMirlConnectCodeWidgetState();
}

class _YourMirlConnectCodeWidgetState extends ConsumerState<YourMirlConnectCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.mirlMagic.tr(),
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.blackColor,
        ),
        40.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.primaryColor,
          title: LocaleKeys.yourMirlConnectCode.tr(),
          titleColor: ColorConstants.textColor,
          onPressed: () {},
          //  onPressed: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen),
        ),
        20.0.spaceY,
        TextFormFieldWidget(
          labelTextSpace: 0.0,
          enabledBorderColor: ColorConstants.borderLightColor,
          onTap: () {},
          height: 45,
          alignment: Alignment.center,
        ),
        TitleSmallText(
          title: LocaleKeys.inviteYourFriend.tr(),
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.greyColor,
        ),
        40.0.spaceY,
        TitleSmallText(
          fontFamily: FontWeightEnum.w600.toInter,
          title: LocaleKeys.moreYouInvite.tr(),
          titleColor: ColorConstants.blackColor,
          maxLine: 2,
        ),
        6.0.spaceY,
        TitleSmallText(
          fontFamily: FontWeightEnum.w400.toInter,
          title: LocaleKeys.turnConnections.tr(),
          titleColor: ColorConstants.blackColor,
          titleTextAlign: TextAlign.center,
          maxLine: 10,
        ),
        20.0.spaceY,
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
