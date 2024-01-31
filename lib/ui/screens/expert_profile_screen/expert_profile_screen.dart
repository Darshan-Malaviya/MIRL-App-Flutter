import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      body: Column(
        children: [
          Image.asset(ImageConstants.exploreImage, fit: BoxFit.fitWidth, width: double.infinity),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: ColorConstants.greyColor,
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 2),
                    //   )
                    // ],
                    color: ColorConstants.whiteColor,
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TitleLargeText(
                          title: StringConstants.yourExpertName,
                          fontFamily: FontWeightEnum.w700.toInter,
                          fontSize: 20,
                          titleColor: ColorConstants.bottomTextColor,
                        ),
                        28.0.spaceY,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                BodySmallText(
                                  title: StringConstants.overallRatting,
                                  fontFamily: FontWeightEnum.w700.toInter,
                                ),
                                10.0.spaceX,
                                HeadlineMediumText(
                                  fontSize: 30,
                                  title: '0',
                                  fontFamily: FontWeightEnum.w700.toInter,
                                  titleColor: ColorConstants.overallRatingColor,
                                ),
                              ],
                            ),
                            18.0.spaceY,
                            Row(
                              children: [
                                BodySmallText(
                                  title: StringConstants.feePer,
                                  fontFamily: FontWeightEnum.w700.toInter,
                                ),
                                10.0.spaceX,
                                HeadlineMediumText(
                                  fontSize: 30,
                                  title: '\$',
                                  fontFamily: FontWeightEnum.w700.toInter,
                                  titleColor: ColorConstants.overallRatingColor,
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
                                onPressed: () {
                                  context.toPushNamed(RoutesConstants.editYourExpertProfileScreen);
                                },
                              ),
                            ),
                            44.0.spaceX,
                            Flexible(
                              child: PrimaryButton(
                                title: StringConstants.shareProfile,
                                onPressed: () {
                                  // context.toPushNamed(RoutesConstants.expertDetailScreen);
                                },
                              ),
                            ),
                          ],
                        ),
                        42.0.spaceY,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TitleMediumText(
                            title: StringConstants.moreAboutMe,
                            fontFamily: FontWeightEnum.w700.toInter,
                          ),
                        ),
                        12.0.spaceY,
                        TitleMediumText(
                          fontFamily: FontWeightEnum.w400.toInter,
                          title: StringConstants.welcomeExpertProfile,
                          titleTextAlign: TextAlign.start,
                        ),
                        20.0.spaceY,
                        TitleMediumText(
                          fontFamily: FontWeightEnum.w400.toInter,
                          title: StringConstants.soWhatNext,
                          maxLine: 5,
                        ),
                        20.0.spaceY,
                        TitleMediumText(
                          fontFamily: FontWeightEnum.w400.toInter,
                          title: StringConstants.clickEditProfile,
                          maxLine: 3,
                        ),
                        20.0.spaceY,
                        TitleMediumText(
                          fontFamily: FontWeightEnum.w400.toInter,
                          title: StringConstants.goodLuck,
                          maxLine: 2,
                        ),
                      ],
                    ).addAllPadding(32),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
