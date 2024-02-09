import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ExpertProfileScreen extends ConsumerStatefulWidget {
  const ExpertProfileScreen({super.key});

  @override
  ConsumerState<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends ConsumerState<ExpertProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);

    return Scaffold(
      backgroundColor: ColorConstants.purpleDarkColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(ImageConstants.exploreImage, fit: BoxFit.fitWidth, width: double.infinity),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: HeadlineMediumText(
                      title: expertWatch.expertName,
                      fontSize: 30,
                      titleColor: ColorConstants.bottomTextColor,
                    ),
                  ),
                  28.0.spaceY,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BodySmallText(
                            title: LocaleKeys.overAllRating.tr(),
                            fontFamily: FontWeightEnum.w400.toInter,
                            titleTextAlign: TextAlign.center,
                          ),
                          10.0.spaceX,
                          HeadlineMediumText(
                            fontSize: 30,
                            title: '-',
                            titleColor: ColorConstants.overallRatingColor,
                            shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          BodySmallText(
                            title: LocaleKeys.feesPerMinute.tr(),
                            fontFamily: FontWeightEnum.w400.toInter,
                            titleTextAlign: TextAlign.center,
                          ),
                          10.0.spaceX,
                          HeadlineMediumText(
                            fontSize: 30,
                            title: '\$${expertWatch.countController.text}',
                            titleColor: ColorConstants.overallRatingColor,
                            shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                          ),
                        ],
                      ),
                    ],
                  ),
                  28.0.spaceY,
                  Row(
                    children: [
                      Flexible(
                        child: PrimaryButton(
                          title: StringConstants.editProfile,
                          buttonTextFontFamily: FontWeightEnum.w400.toInter,
                          onPressed: () {
                            context.toPushNamed(RoutesConstants.editYourExpertProfileScreen);
                          },
                        ),
                      ),
                      44.0.spaceX,
                      Flexible(
                        child: PrimaryButton(
                          title: StringConstants.shareProfile,
                          buttonTextFontFamily: FontWeightEnum.w400.toInter,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  42.0.spaceY,
                  TitleMediumText(
                    title: StringConstants.moreAboutMe,
                    titleColor: ColorConstants.blueColor,
                  ),
                  12.0.spaceY,
                  TitleMediumText(
                    title: StringConstants.welcomeExpertProfile,
                    fontFamily: FontWeightEnum.w400.toInter,
                    maxLine: 2,
                  ),
                  20.0.spaceY,
                  TitleMediumText(
                    fontFamily: FontWeightEnum.w400.toInter,
                    title: StringConstants.soWhatNext,
                    maxLine: 10,
                  ),
                  20.0.spaceY,
                  TitleMediumText(
                    fontFamily: FontWeightEnum.w400.toInter,
                    title: StringConstants.clickEditProfile,
                    maxLine: 6,
                  ),
                  20.0.spaceY,
                  TitleMediumText(
                    fontFamily: FontWeightEnum.w400.toInter,
                    title: StringConstants.goodLuck,
                    maxLine: 10,
                  ),
                ],
              ).addAllPadding(32),
            ),
          ],
        ),
      ),
    );
  }
}
