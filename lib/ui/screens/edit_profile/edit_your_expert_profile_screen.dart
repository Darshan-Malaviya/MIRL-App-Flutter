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
            fontFamily: FontWeightEnum.w700.toInter,
          ).addPaddingRight(14),
        ),
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
                height: MediaQuery.sizeOf(context).height * 0.45,
                width: MediaQuery.sizeOf(context).width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConstants.borderColor, width: 1.5),
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
              ),
            ),
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
                    expertRead.getUserData();
                    context.toPushNamed(RoutesConstants.yourExpertProfileName);
                  },
                  height: 40,
                  labelText: StringConstants.expertName,
                  controller: TextEditingController(text: expertWatch.expertName),
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  isReadOnly: true,
                  onTap: () {
                    expertRead.getUserData();
                    context.toPushNamed(RoutesConstants.yourMirlId);
                  },
                  height: 40,
                  labelText: StringConstants.yourMirlId,
                  controller: TextEditingController(text: expertWatch.mirlId),
                ),
                8.0.spaceY,
                TextFormFieldWidget(
                  isReadOnly: true,
                  onTap: () {
                    expertRead.getUserData();
                    context.toPushNamed(RoutesConstants.moreAboutMeScreen);
                  },
                  maxLines: 10,
                  minLines: 10,
                  labelText: StringConstants.moreAboutMe,
                  controller: TextEditingController(text: expertWatch.aboute),
                ),
                50.0.spaceY,
                Column(
                  children: List.generate(expertWatch.editButtonList.length, (index) {
                    final data = expertWatch.editButtonList[index];
                    return PrimaryButton(
                      buttonColor: (data.isSelected ?? false) ? null : ColorConstants.buttonColor,
                      title: data.title ?? '',
                      onPressed: () => expertRead.changeSelectedScreenButtonColor(context, index),
                    ).addPaddingBottom(50);
                  }),
                ),
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
