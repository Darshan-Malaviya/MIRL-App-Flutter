import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';

class ThanksGivingScreen extends ConsumerStatefulWidget {
  const ThanksGivingScreen({super.key});

  @override
  ConsumerState createState() => _ThanksGivingScreenState();
}

class _ThanksGivingScreenState extends ConsumerState<ThanksGivingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleLargeText(
            title: LocaleKeys.whyNotThinkOfThat.tr(),
            fontWeight: FontWeight.w700,
            maxLine: 2,
            titleTextAlign: TextAlign.center,
            titleColor: ColorConstants.bottomTextColor,
          ),
          10.0.spaceY,
          BodyMediumText(
            title: LocaleKeys.thanksNote.tr(),
            maxLine: 4,
            titleTextAlign: TextAlign.center,
          ),
          50.0.spaceY,
          Image.asset(
            ImageConstants.suggestNewExpertise,
          ),
          70.0.spaceY,
          PrimaryButton(title: LocaleKeys.backToExpertCategories.tr(), onPressed: () {
            context.toPop();
          })
        ],
      ).addPaddingXY(paddingX: 30, paddingY: 10),
    );
  }
}
