import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/edit_profile/widget/image_picker_option.dart';

class EditYourExpertProfileScreen extends ConsumerStatefulWidget {
  const EditYourExpertProfileScreen({super.key});

  @override
  ConsumerState<EditYourExpertProfileScreen> createState() => _EditYourExpertProfileScreenState();
}

class _EditYourExpertProfileScreenState extends ConsumerState<EditYourExpertProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);

    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(
          onTap: () => expertRead.updateProfileApi(),
          child: TitleMediumText(
            title: StringConstants.done,
          ).addPaddingRight(14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleLargeText(
              title: StringConstants.editYourExpertProfile,
              titleColor: ColorConstants.bottomTextColor,
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
                      expertRead.captureCameraImage(context);
                    },
                    onTapGalley: () {
                      context.toPop();
                      expertRead.pickGalleryImage(context);
                    },
                  ),
                );
              },
              child: Container(
                height: MediaQuery
                    .sizeOf(context)
                    .height * 0.45,
                width: MediaQuery
                    .sizeOf(context)
                    .width * 0.7,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.borderLightColor,
                    ),
                    const BoxShadow(
                      color: ColorConstants.whiteColor,
                      spreadRadius: 0.0,
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConstants.borderLightColor, width: 1.5),
                ),
                child: (expertWatch.pickedImage.isNotEmpty)
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: NetworkImageWidget(
                    imageURL: expertWatch.pickedImage,
                    isNetworkImage: expertWatch.pickedImage.contains('https'),
                    boxFit: BoxFit.cover,
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BodySmallText(
                      title: StringConstants.expertProfilePhoto,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                    20.0.spaceY,
                    BodySmallText(
                      title: StringConstants.highQualityProfile,
                      titleTextAlign: TextAlign.center,
                      fontFamily: FontWeightEnum.w400.toInter,
                      maxLine: 5,
                    ),
                    20.0.spaceY,
                    BodySmallText(
                      title: StringConstants.yourFavoriteOne,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                  ],
                ),
              ),
            ),
            5.0.spaceY,
            BodySmallText(
              title: StringConstants.editExpertProfile,
            ),
            30.0.spaceY,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleMediumText(
                  title: StringConstants.editYourDetails,
                  titleColor: ColorConstants.blueColor,
                ),
                18.0.spaceY,
                TextFormFieldWidget(
                  enabledBorderColor: ColorConstants.borderLightColor,
                  isReadOnly: true,
                  onTap: () {
                    expertRead.getUserData();
                    context.toPushNamed(RoutesConstants.yourExpertProfileName);
                  },
                  height: 40,
                  labelText: StringConstants.expertName,
                  alignment: Alignment.centerLeft,
                  labelTextSpace: 0.0,
                  controller: TextEditingController(text: expertWatch.expertName),
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  labelTextSpace: 0.0,
                  enabledBorderColor: ColorConstants.borderLightColor,
                  isReadOnly: true,
                  onTap: () {
                    expertRead.getUserData();
                    context.toPushNamed(RoutesConstants.yourMirlId);
                  },
                  height: 40,
                  labelText: StringConstants.yourMirlId,
                  alignment: Alignment.centerLeft,
                  controller: TextEditingController(text: expertWatch.mirlId),
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  labelTextSpace: 0.0,
                  enabledBorderColor: ColorConstants.borderLightColor,
                  isReadOnly: true,
                  onTap: () {
                    expertRead.getUserData();
                    context.toPushNamed(RoutesConstants.moreAboutMeScreen);
                  },
                  maxLines: 10,
                  minLines: 10,
                  labelText: StringConstants.moreAboutMe,
                  alignment: Alignment.centerLeft,
                  controller: TextEditingController(text: expertWatch.about),
                ),
                50.0.spaceY,
                Column(
                  children: List.generate(expertWatch.editButtonList.length, (index) {
                    final data = expertWatch.editButtonList[index];
                    return PrimaryButton(
                      buttonColor: (data.isSelected ?? false) ? null : ColorConstants.buttonColor,
                      fontSize: 12,
                      title: data.title ?? '',
                      onPressed: () => expertRead.redirectSelectedButton(context, index),
                    ).addPaddingBottom(50);
                  }),
                ),
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.calendar,
                  titleColor: ColorConstants.buttonTextColor,
                  onPressed: () => context.toPushNamed(RoutesConstants.viewCalendarAppointment,args: '2'),
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.reviewsAndRatings,
                  titleColor: ColorConstants.buttonTextColor,
                  onPressed: () => context.toPushNamed(RoutesConstants.ratingAndReviewScreen),
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.earningReports,
                  titleColor: ColorConstants.buttonTextColor,
                  onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.callHistory,
                  titleColor: ColorConstants.buttonTextColor,
                  onPressed: () {},
                ),
                50.0.spaceY,
                PrimaryButton(
                  buttonColor: ColorConstants.yellowButtonColor,
                  title: StringConstants.blockedUsersList,
                  titleColor: ColorConstants.buttonTextColor,
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
