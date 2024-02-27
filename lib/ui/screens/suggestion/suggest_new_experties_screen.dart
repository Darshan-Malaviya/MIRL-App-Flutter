import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/filter_screen/widget/all_category_list_bottom_view.dart';

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
    final filterWatch = ref.watch(filterProvider);
    return Scaffold(
        backgroundColor: ColorConstants.scaffoldBg,
        appBar: AppBarWidget(
          appBarColor: ColorConstants.scaffoldBg,
          leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () {
                filterWatch.categoryController.clear();
                context.toPop();
              }),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleLargeText(
              title: LocaleKeys.suggestNewExpertise.tr(),
              fontSize: 20,
            ),
            10.0.spaceY,
            BodySmallText(
              title: LocaleKeys.suggestNewExpertiseNote.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.center,
              maxLine: 10,
            ),
            10.0.spaceY,
            BodySmallText(
              title: LocaleKeys.suggestNewExpertiseSubNote.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.center,
              maxLine: 10,
            ),
            20.0.spaceY,
            ShadowContainer(
              shadowColor: ColorConstants.primaryColor,
              offset: Offset(0, 0),
              spreadRadius: 1,
              blurRadius: 8,
              child: Column(
                children: [
                  Image.asset(
                    ImageConstants.unlockSuggest,
                  ),
                  4.0.spaceY,
                  LabelSmallText(
                    fontSize: 9,
                    title: LocaleKeys.unlock.tr(),
                    titleColor: ColorConstants.blackColor,
                    titleTextAlign: TextAlign.center,
                    maxLine: 2,
                  ),
                ],
              ),
              height: 95,
              width: 95,
              isShadow: true,
            ),
            // 20.0.spaceY,
            // CategoryCommonView(
            //   onTap: () {},
            //   categoryName: 'UNLOCK!',
            //   imageUrl: ImageConstants.suggestNewExpertise,
            //   isSelectedShadow: true,
            //   blurRadius: 8,
            //   spreadRadius: 1,
            //   offset: Offset(0, 0),
            // ),
            20.0.spaceY,
            TitleSmallText(
              title: LocaleKeys.selectExpertCategory.tr(),
              fontSize: 15,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.bottomTextColor,
            ),
            20.0.spaceY,
            buildTextFormFieldWidget(filterWatch.categoryController, context, () {
              CommonBottomSheet.bottomSheet(context: context, isDismissible: true, child: AllCategoryListBottomView());
            }),
            20.0.spaceY,
            TitleSmallText(
              title: LocaleKeys.or.tr(),
              fontSize: 15,
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.buttonTextColor,
            ),
            20.0.spaceY,
            TitleSmallText(
              title: LocaleKeys.suggestNewExpertCategory.tr(),
              fontSize: 15,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.bottomTextColor,
            ),
            15.0.spaceY,
            TextFormFieldWidget(
              hintText: LocaleKeys.newExpertisePlaceHolder.tr(),
              controller: suggestNewExpertiseWatch.expertCategoryController,
              enabledBorderColor: ColorConstants.dropDownBorderColor,
              hintTextColor: ColorConstants.buttonTextColor,
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
                  contentPadding: EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 30),
                  borderRadius: 25,
                  borderWidth: 0,
                  enabledBorderColor: ColorConstants.transparentColor,
                  fillColor: ColorConstants.transparentColor,
                  enableShadow: true,
                  focusedBorderColor: ColorConstants.transparentColor,
                  onFieldSubmitted: (value) {
                    context.unFocusKeyboard();
                  },
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
            40.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.shareSuggestion.tr(),
              onPressed: () {
                //context.unFocusKeyboard();
                FocusManager.instance.primaryFocus?.unfocus();
                if (suggestNewExpertiseRead.newTopicController.text.isNotEmpty) {
                  suggestNewExpertiseRead.suggestedCategoryApiCall(categoryId: filterWatch.selectedCategory?.id ?? null);
                } else {
                  FlutterToast().showToast(msg: LocaleKeys.enterTopic.tr(), gravity: ToastGravity.TOP);
                }
              },
            )
          ],
        ).addPaddingXY(paddingX: 30, paddingY: 10)));
  }

  TextFormFieldWidget buildTextFormFieldWidget(
    TextEditingController controller,
    BuildContext context,
    VoidCallback OnTap,
  ) {
    return TextFormFieldWidget(
      isReadOnly: true,
      hintText: LocaleKeys.selectExistingCategory.tr(),
      controller: controller,
      // labelColor: ColorConstants.bottomTextColor,
      enabledBorderColor: ColorConstants.dropDownBorderColor,
      // labelTextFontFamily: FontWeightEnum.w700.toInter,
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: FontWeightEnum.w400.toInter, overflow: TextOverflow.ellipsis),
      suffixIcon: Icon(
        size: 24,
        Icons.keyboard_arrow_down_rounded,
        color: ColorConstants.buttonTextColor,
      ),
      hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, overflow: TextOverflow.ellipsis),
      onTap: OnTap,
    );
  }
}
