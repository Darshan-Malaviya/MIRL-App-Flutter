import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SuggestNewExpertiseScreen extends ConsumerStatefulWidget {
  const SuggestNewExpertiseScreen({super.key});

  @override
  ConsumerState createState() => _SuggestNewExpertiseScreenState();
}

class _SuggestNewExpertiseScreenState extends ConsumerState<SuggestNewExpertiseScreen> {
  @override
  Widget build(BuildContext context) {
    final suggestNewExpertiseWatch = ref.watch(suggestNewExpertiseProvider);
    final suggestNewExpertiseRead = ref.read(suggestNewExpertiseProvider);
    return Scaffold(
      backgroundColor: ColorConstants.greyLightColor,
        appBar: AppBarWidget(
          appBarColor: ColorConstants.greyLightColor,
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: LocaleKeys.suggestNewExpertise.tr(),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              10.0.spaceY,
              BodySmallText(
                title: LocaleKeys.suggestNewExpertiseNote.tr(),
                fontWeight: FontWeight.w400,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              10.0.spaceY,
              BodySmallText(
                title: LocaleKeys.suggestNewExpertiseSubNote.tr(),
                fontWeight: FontWeight.w400,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
              250.0.spaceY,
              TitleSmallText(
                title: LocaleKeys.suggestNewExpertCategory.tr(),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.bottomTextColor,
              ),
              15.0.spaceY,
              TextFormFieldWidget(
                hintText: LocaleKeys.newExpertisePlaceHolder.tr(),
                controller: suggestNewExpertiseWatch.expertCategoryController,
                enabledBorderColor: ColorConstants.dropDownBorderColor,
                hintTextColor: ColorConstants.buttonTextColor,
                /* inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],*/
                onFieldSubmitted: (value) {
                  context.unFocusKeyboard();
                },
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                textInputAction: TextInputAction.done,
              ),
              40.0.spaceY,
              TitleSmallText(
                title: LocaleKeys.suggestNewTopic.tr(),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                titleTextAlign: TextAlign.center,
                titleColor: ColorConstants.bottomTextColor,
              ),
              20.0.spaceY,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextFormFieldWidget(
                    onChanged: suggestNewExpertiseRead.newTopicCounterValue,
                    hintText: LocaleKeys.suggestNewExpertCategoryNote.tr(),
                    hintTextColor: ColorConstants.buttonTextColor,
                    maxLines: 10,
                    maxLength: 500,
                    minLines: 8,
                    controller: suggestNewExpertiseRead.newTopicController,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    contentPadding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 30),
                    borderRadius: 25,
                    borderWidth: 0,
                    enabledBorderColor: ColorConstants.transparentColor,
                    fillColor: ColorConstants.transparentColor,
                    enableShadow: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 12),
                    child: BodySmallText(
                      title: '${suggestNewExpertiseRead.enteredText}/500 ${LocaleKeys.characters.tr()}',
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ],
              ),
              20.0.spaceY,
              20.0.spaceY,
              PrimaryButton(
                  title: LocaleKeys.shareSuggestion.tr(),
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.thanksGivingScreen);
                  })
            ],
          ).addPaddingXY(paddingX: 30, paddingY: 10),
        ));
  }
}
