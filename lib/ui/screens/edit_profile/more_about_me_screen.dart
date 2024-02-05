import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class MoreAboutMeScreen extends ConsumerStatefulWidget {
  const MoreAboutMeScreen({super.key});

  @override
  ConsumerState<MoreAboutMeScreen> createState() => _MoreAboutMeScreenState();
}

class _MoreAboutMeScreenState extends ConsumerState<MoreAboutMeScreen> {
  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.watch(editExpertProvider);

    return Scaffold(
        appBar: AppBarWidget(
            leading: InkWell(
              child: Image.asset(ImageConstants.backIcon),
              onTap: () => context.toPop(),
            ),
            trailingIcon: InkWell(
              onTap: () {
                expertRead.updateAboutApi();
              },
              child: TitleMediumText(
                title: StringConstants.done,
              ).addPaddingRight(14),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleLargeText(
                title: StringConstants.moreAboutMe,
                titleColor: ColorConstants.bottomTextColor,
              ),
              60.0.spaceY,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextFormFieldWidget(
                    onChanged: expertRead.changeAboutCounterValue,
                    maxLines: 10,
                    maxLength: 1500,
                    minLines: 8,
                    controller: expertWatch.aboutMeController,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    contentPadding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,right: 12),
                    child: BodySmallText(
                      title: '${expertWatch.enteredText}/1500 ${LocaleKeys.characters.tr()}',
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ],
              ),
              30.0.spaceY,
              TitleSmallText(
                fontFamily: FontWeightEnum.w400.toInter,
                title: StringConstants.professionalSkills,
                titleTextAlign: TextAlign.center,
                maxLine: 10,
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
