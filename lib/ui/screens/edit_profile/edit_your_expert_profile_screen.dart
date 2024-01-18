import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/handler/media_picker_handler/media_picker.dart';
import 'package:mirl/ui/screens/edit_profile/widget/image_picker_option.dart';

class EditYourExpertProfileScreen extends ConsumerStatefulWidget {
  const EditYourExpertProfileScreen({super.key});

  @override
  ConsumerState<EditYourExpertProfileScreen> createState() => _EditYourExpertProfileScreenState();
}

class _EditYourExpertProfileScreenState extends ConsumerState<EditYourExpertProfileScreen> {
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
    final expertRead = ref.watch(editExpertProvider);
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
          children: [
            TitleLargeText(
              title: StringConstants.editYourExpertProfile,
              titleColor: ColorConstants.bottomTextColor,
              fontFamily: FontWeightEnum.w700.toInter,
            ),
            20.0.spaceY,
            InkWell(
              onTap: () {
                CommonBottomSheet.bottomSheet(
                  context: context,
                  isDismissible: true,
                  child: ImagePickerBottomSheet(
                    onTapCamera: () {
                      context.toPop();
                    },
                    onTapGalley: () {
                      context.toPop();
                      ImagePickerHandler.singleton.pickImageFromGallery(context: context);
                    },
                  ),
                );
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BodySmallText(
                      title: StringConstants.expertProfilePhoto,
                    ),
                    20.0.spaceY,
                    BodySmallText(
                      title: StringConstants.highQualityProfile,
                      titleTextAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                    20.0.spaceY,
                    BodySmallText(
                      title: StringConstants.yourFavoriteOne,
                    ),
                  ],
                ),
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorConstants.borderColor,
                    width: 1.5,
                  ),
                ),
              ),
            ) /*.addMarginX(45)*/,
            5.0.spaceY,
            BodySmallText(
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
                  isReadOnly: true,
                  onTap: () {
                    context.toPushNamed(RoutesConstants.yourExpertProfileName);
                  },
                  height: 40,
                  labelText: StringConstants.expertName,
                  controller: expertWatch.expertNameController,
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  isReadOnly: true,
                  onTap: () {
                    context.toPushNamed(RoutesConstants.yourMirlId);
                  },
                  height: 40,
                  labelText: StringConstants.yourMirlId,
                  controller: expertWatch.mirlIdController,
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  isReadOnly: true,
                  onTap: () {
                    context.toPushNamed(RoutesConstants.moreAboutMeScreen);
                  },
                  maxLines: 10,
                  minLines: 10,
                  labelText: StringConstants.moreAboutMe,
                  controller: expertWatch.aboutMeController,
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
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.setWeeklyAvailability);
                  },
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
                    context.toPushNamed(RoutesConstants.setYourLocationScreen);
                  },
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.buttonColor,
                  title: StringConstants.setYourGender,
                  onPressed: () {
                    context.toPushNamed(RoutesConstants.setYourGenderScreen);
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
                  onPressed: () {},
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
