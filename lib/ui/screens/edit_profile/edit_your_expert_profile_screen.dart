import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class EditYourExpertProfileScreen extends ConsumerStatefulWidget {
  const EditYourExpertProfileScreen({super.key});

  @override
  ConsumerState<EditYourExpertProfileScreen> createState() => _EditYourExpertProfileScreenState();
}

class _EditYourExpertProfileScreenState extends ConsumerState<EditYourExpertProfileScreen> {
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
          title: StringConstants.editYourExpertProfile,
          titleColor: ColorConstants.bottomTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BodySmallText(
                    title: StringConstants.expertProfilePhoto,
                    titleColor: ColorConstants.blackColor,
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                  20.0.spaceY,
                  BodySmallText(
                    title: StringConstants.highQualityProfile,
                    titleColor: ColorConstants.blackColor,
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                  20.0.spaceY,
                  BodySmallText(
                    title: StringConstants.yourFavoriteOne,
                    titleColor: ColorConstants.blackColor,
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleTextAlign: TextAlign.center,
                    fontSize: 15,
                  ),
                ],
              ),
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorConstants.borderColor, //<---- Insert Gradient Here
                  width: 1.5,
                ),
              ),
            ).addMarginX(45),
            5.0.spaceY,
            TitleMediumText(
              title: StringConstants.editExpertProfile,
              fontFamily: FontWeightEnum.w700.toInter,
            ),
            30.0.spaceY,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleMediumText(
                  title: StringConstants.editYourDetails,
                  fontFamily: FontWeightEnum.w700.toInter,
                ),
                18.0.spaceY,
                TextFormFieldWidget(
                  height: 40,
                  fontFamily: FontWeightEnum.w400.toInter,
                  labelText: StringConstants.expertName,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  height: 40,
                  fontFamily: FontWeightEnum.w400.toInter,
                  labelText: StringConstants.yourMirlId,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  contentPadding: EdgeInsets.symmetric(vertical: 110, horizontal: 2),
                  fontFamily: FontWeightEnum.w400.toInter,
                  labelText: StringConstants.moreAboutMe,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                ),
                50.0.spaceY,
                PrimaryButton(
                  title: StringConstants.setYourFee,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.setYourFreeScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.areasOfExpertise,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.addYourAreasOfExpertiseScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.weeklyAvailability,
                  onPressed: () {},
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.callsAvailability,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.instantCallsAvailabilityScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.setYourLocation,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.srtYourLocationScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.setYourGender,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.srtYourGenderScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.addCertifications,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.certificationsAndExperienceScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.bankAccountDetails,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.yourBankAccountDetailsScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.calendar,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.demoListScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.reviews,
                  onPressed: () {},
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.earningReports,
                  onPressed: () {},
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.callHistory,
                  onPressed: () {},
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.blockedUsersList,
                  onPressed: () {},
                ),
                50.0.spaceY,
              ],
            ).addPaddingX(45),
            //.addMarginXY( paddingX: 40,paddingY: 40),
          ],
        ),
      ),
    );
  }
}
