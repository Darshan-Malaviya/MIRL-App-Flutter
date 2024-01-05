import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/button_widget/primary_button.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/common/text_widgets/textfield/textformfield_widget.dart';

class CertificationsAndExperienceScreen extends ConsumerStatefulWidget {
  const CertificationsAndExperienceScreen({super.key});

  @override
  ConsumerState<CertificationsAndExperienceScreen> createState() => _CertificationsAndExperienceScreenState();
}

class _CertificationsAndExperienceScreenState extends ConsumerState<CertificationsAndExperienceScreen> {
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
            title: StringConstants.certificationsAndExperience,
            titleColor: ColorConstants.bottomTextColor,
            fontFamily: FontWeightEnum.w700.toInter,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleSmallText(
                title: StringConstants.trustYourAbilities,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.mediaAccount,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              50.0.spaceY,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleSmallText(
                  title: "1.",
                  titleColor: ColorConstants.blackColor,
                  fontFamily: FontWeightEnum.w700.toInter,
                  titleTextAlign: TextAlign.start,
                  fontSize: 15,
                ),
              ),
              24.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.writeYourTitle,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.sourceUrl,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                height: 100,
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.description,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleSmallText(
                  title: "2.",
                  titleColor: ColorConstants.blackColor,
                  fontFamily: FontWeightEnum.w700.toInter,
                  titleTextAlign: TextAlign.start,
                  fontSize: 15,
                ),
              ),
              24.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.writeYourTitle,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.sourceUrl,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                height: 100,
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.description,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
              PrimaryButton(
                title: StringConstants.addMoreCredentials,
                onPressed: () {},
              ),
              20.0.spaceY,
            ],
          ).addAllPadding(24),
        ));
  }
}
