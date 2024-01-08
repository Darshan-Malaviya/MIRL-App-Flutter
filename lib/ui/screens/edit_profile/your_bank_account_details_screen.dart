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
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: StringConstants.bankAccountDetails,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
                maxLine: 2,
                titleTextAlign: TextAlign.center,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.shareBankAccountDetails,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.updateBankAccountDetails,
                titleTextAlign: TextAlign.center,
                maxLine: 2,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.informationRequired,
                titleTextAlign: TextAlign.center,
                maxLine: 2,
              ),
              12.0.spaceY,
              TextFormFieldWidget(
                hintText: StringConstants.nameBankAccount,
                textAlign: TextAlign.start,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                hintText: StringConstants.bankName,
                textAlign: TextAlign.start,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                hintText: StringConstants.accountNumber,
                textInputAction: TextInputAction.done,
              ),
            ],
          ).addAllPadding(24),
        ));
  }
}
