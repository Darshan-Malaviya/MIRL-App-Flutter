import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';

class CertificationsAndExperienceScreen extends ConsumerStatefulWidget {
  const CertificationsAndExperienceScreen({super.key});

  @override
  ConsumerState<CertificationsAndExperienceScreen> createState() => _CertificationsAndExperienceScreenState();
}

class _CertificationsAndExperienceScreenState extends ConsumerState<CertificationsAndExperienceScreen> {
  final _loginPassKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).getUserData();
      ref.read(editExpertProvider).generateExperienceList(fromInit: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);

    return Scaffold(
        appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              expertWatch.certiAndExpModel.clear();
              expertWatch.certificationList.clear();
              context.toPop();
            },
          ),
          trailingIcon: OnScaleTap(
            onPress: () {
              context.unFocusKeyboard();
              if (_loginPassKey.currentState?.validate() ?? false) {
                expertRead.expertCertificateApi(context);
              }
            },
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _loginPassKey,
            child: Column(
              children: [
                TitleLargeText(
                  title: StringConstants.certificationsAndExperience,
                  titleColor: ColorConstants.bottomTextColor,
                  fontFamily: FontWeightEnum.w700.toInter,
                  titleTextAlign: TextAlign.center,
                  maxLine: 2,
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.trustYourAbilities,
                  titleTextAlign: TextAlign.center,
                  maxLine: 5,
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.mediaAccount,
                  titleTextAlign: TextAlign.center,
                  maxLine: 5,
                ),
                50.0.spaceY,
                Column(
                  children: List.generate(
                    expertWatch.certiAndExpModel.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.0.spaceY,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleSmallText(
                              title: '${index + 1}.',
                              fontFamily: FontWeightEnum.w700.toInter,
                              fontSize: 15,
                            ),
                            InkWell(
                              onTap: () {
                                expertRead.expertCertificateDeleteApi(
                                    context: context, certiId: expertWatch.certiAndExpModel[index].id, index: index);
                              },
                              child: TitleSmallText(
                                title: StringConstants.delete,
                                titleColor: ColorConstants.errorColor,
                                fontFamily: FontWeightEnum.w700.toInter,
                              ),
                            ).addVisibility(index != 0),
                          ],
                        ),
                        20.0.spaceY,
                        TextFormFieldWidget(textStyle: TextStyle(fontFamily: FontWeightEnum.w700.toInter),
                          controller: expertWatch.certiAndExpModel[index].titleController,
                          focusNode: expertWatch.certiAndExpModel[index].titleFocus,
                          hintText: StringConstants.writeYourTitle,
                          fontFamily: FontWeightEnum.w700.toInter,
                          maxLines: 2,
                          textInputType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            expertWatch.certiAndExpModel[index].titleFocus.toChangeFocus(
                                currentFocusNode: expertWatch.certiAndExpModel[index].titleFocus,
                                nexFocusNode: expertWatch.certiAndExpModel[index].urlFocus);
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: (value) => value?.toEmptyStringValidation(msg: StringConstants.requiredTitle),
                        ),
                        20.0.spaceY,
                        TextFormFieldWidget(
                          controller: expertWatch.certiAndExpModel[index].urlController,
                          focusNode: expertWatch.certiAndExpModel[index].urlFocus,
                          hintText: LocaleKeys.sourceLinkHint.tr(),
                          onFieldSubmitted: (value) {
                            expertWatch.certiAndExpModel[index].urlFocus.toChangeFocus(
                                currentFocusNode: expertWatch.certiAndExpModel[index].urlFocus,
                                nexFocusNode: expertWatch.certiAndExpModel[index].descriptionFocus);
                          },
                          validator: (urlValue) {
                            return urlValue?.toUrlValidation(urlValue);
                          }
                          //   RegExp regex =
                          //   RegExp(r'^https?:\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[^\s]*)?$');
                          //   var value = urlValue ?? "";
                          //  if (!regex.hasMatch(value)) {
                          //     return ("Please enter a valid URL");
                          //   }
                          //   return null;
                          // },
                        ),
                        20.0.spaceY,
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            TextFormFieldWidget(
                              onChanged: expertRead.changeCertificationsValue,
                              controller: expertWatch.certiAndExpModel[index].descriptionController,
                              focusNode: expertWatch.certiAndExpModel[index].descriptionFocus,
                              maxLines: 5,
                              minLines: 5,
                              hintText: StringConstants.description,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {
                                expertWatch.certiAndExpModel[index].descriptionFocus.unfocus();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8, right: 12),
                              child: BodySmallText(
                                title: '${expertWatch.enteredCertificateText}/200 ${LocaleKeys.characters.tr()}',
                                fontFamily: FontWeightEnum.w400.toInter,
                                titleColor: ColorConstants.buttonTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                40.0.spaceY,
                PrimaryButton(
                  title: StringConstants.addMoreCredentials,
                  onPressed: () {
                    expertRead.generateExperienceList(fromInit: false);
                  },
                ),
                20.0.spaceY,
              ],
            ).addAllPadding(24),
          ),
        ));
  }
}
