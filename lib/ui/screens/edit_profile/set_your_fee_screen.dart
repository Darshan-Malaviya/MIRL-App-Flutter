import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/ui/common/button_widget/minus_button.dart';
import 'package:mirl/ui/common/button_widget/plus_button.dart';

class SetYourFreeScreen extends ConsumerStatefulWidget {
  const SetYourFreeScreen({super.key});

  @override
  ConsumerState<SetYourFreeScreen> createState() => _SetYourFreeScreenState();
}

class _SetYourFreeScreenState extends ConsumerState<SetYourFreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading:  InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        trailingIcon: TitleMediumText(
          title: StringConstants.done,
          fontFamily: FontWeightEnum.w700.toInter,
        ).addPaddingRight(14),
        appTitle: TitleLargeText(
          title: StringConstants.setYourFee,
          titleColor: ColorConstants.bottomTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlusButtonWidget(),
              TextFormFieldWidget(
                width: 150,
                fontFamily: FontWeightEnum.w400.toInter,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ).addAllPadding(16),
              MinusButtonWidget(),
            ],
          ),
          TitleSmallText(
            title: StringConstants.currency,
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
          ),
          10.0.spaceY,
          TitleSmallText(
            title: StringConstants.appFees,
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
          ),
          4.0.spaceY,
          TitleSmallText(
              title: StringConstants.ourAppFees,
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.bottomTextColor),
          PrimaryButton(title: StringConstants.userFees, onPressed: () {}).addAllPadding(50),
        ],
      ),
    );
  }
}