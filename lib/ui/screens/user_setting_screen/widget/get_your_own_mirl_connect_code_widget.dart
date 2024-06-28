import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class GetYourOwnMirlConnectCodeWidget extends ConsumerStatefulWidget {
  const GetYourOwnMirlConnectCodeWidget({super.key});

  @override
  ConsumerState<GetYourOwnMirlConnectCodeWidget> createState() => _GetYourOwnMirlConnectCodeWidgetState();
}

class _GetYourOwnMirlConnectCodeWidgetState extends ConsumerState<GetYourOwnMirlConnectCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.0.spaceY,
        TitleSmallText(
          title: LocaleKeys.friendReferralCode.tr().toUpperCase(),
          fontFamily: FontWeightEnum.w600.toInter,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
          titleColor: ColorConstants.blackColor,
        ),
        20.0.spaceY,
        TextFormFieldWidget(
          labelTextSpace: 0.0,
          borderWidth: 1,
          onTap: () {},
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            context.unFocusKeyboard();
          },
          height: 45,
          hintText: LocaleKeys.friendReferralCode.tr(),
          alignment: Alignment.centerLeft,
        ),
        20.0.spaceY,
        PrimaryButton(
          buttonColor: ColorConstants.primaryColor,
          title: LocaleKeys.mirlConnectCode.tr(),
          titleColor: ColorConstants.textColor,
          onPressed: () => mirlConnectView.value = 2,
        ),
        40.0.spaceY,
        LabelSmallText(
          title: LocaleKeys.inaugural.tr(),
          titleColor: ColorConstants.primaryColor,
          titleTextAlign: TextAlign.center,
          maxLine: 2,
          fontSize: 10,
        ),
        60.0.spaceY,
        // TitleSmallText(
        //   fontFamily: FontWeightEnum.w500.toInter,
        //   title: LocaleKeys.referralCode.tr(),
        //   titleColor: ColorConstants.blackColor,
        //   titleTextAlign: TextAlign.center,
        //   maxLine: 10,
        // ),
        RichText(
          softWrap: true,
          textAlign: TextAlign.center,
          text: TextSpan(
            text: LocaleKeys.referralCode.tr(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorConstants.blackColor, fontFamily: FontWeightEnum.w500.toInter),
            children: [
              WidgetSpan(child: 2.0.spaceX),
              TextSpan(
                text: LocaleKeys.referral.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorConstants.bottomTextColor, fontFamily: FontWeightEnum.w500.toInter),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
