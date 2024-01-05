import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/common/text_widgets/textfield/textformfield_widget.dart';

class YourBankAccountDetailsScreen extends ConsumerStatefulWidget {
  const YourBankAccountDetailsScreen({super.key});

  @override
  ConsumerState<YourBankAccountDetailsScreen> createState() => _YourBankAccountDetailsScreenState();
}

class _YourBankAccountDetailsScreenState extends ConsumerState<YourBankAccountDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          leading: InkWell(
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
            title: StringConstants.bankAccountDetails,
            titleColor: ColorConstants.bottomTextColor,
            fontFamily: FontWeightEnum.w700.toInter,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleSmallText(
                title: StringConstants.shareBankAccountDetails,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.updateBankAccountDetails,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.informationRequired,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              12.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.nameBankAccount,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.bankName,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.accountNumber,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
            ],
          ).addAllPadding(24),
        ));
  }
}
