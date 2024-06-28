import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/screens/edit_profile/widget/image_picker_option.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  // final ScrollController scrollController;
  const UserSettingScreen({super.key/*,required this.scrollController*/});

  @override
  ConsumerState<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userSettingProvider).getUserSettingData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userSettingWatch = ref.watch(userSettingProvider);
    final userSettingRead = ref.read(userSettingProvider);

    return Scaffold(
        appBar: AppBarWidget(
          // trailingIcon: InkWell(
          //   onTap: () => userSettingWatch.pickedImage.isNotEmpty ? userSettingRead.updateProfileApi() : null,
          //   child: TitleMediumText(
          //     title: StringConstants.done,
          //   ).addPaddingRight(14),
          // ),
        ),
        body: SingleChildScrollView(
          controller:scrollController,
          child: Column(
            children: [
              TitleLargeText(
                title: LocaleKeys.userProfileAndSetting.tr(),
                titleColor: ColorConstants.bottomTextColor,
                titleTextAlign: TextAlign.center,
              ),
              20.0.spaceY,
              BodySmallText(
                title: LocaleKeys.editUserPicture.tr(),
                titleColor: ColorConstants.blackColor,
                titleTextAlign: TextAlign.center,
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
                        userSettingRead.captureCameraImage(context);
                      },
                      onTapGalley: () {
                        context.toPop();
                        userSettingRead.pickGalleryImage(context);
                      },
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          //color: ColorConstants.blackColor.withOpacity(0.25),
                          color: ColorConstants.borderLightColor),
                      const BoxShadow(
                        color: ColorConstants.whiteColor,
                        spreadRadius: 0.0,
                        blurRadius: 4.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: (userSettingWatch.pickedImage.isNotEmpty)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: NetworkImageWidget(
                            imageURL: userSettingWatch.pickedImage,
                            isNetworkImage: userSettingWatch.pickedImage.contains('https'),
                            boxFit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LabelSmallText(
                              title: LocaleKeys.addYourPicture.tr(),
                              titleTextAlign: TextAlign.center,
                              fontFamily: FontWeightEnum.w400.toInter,
                              fontSize: 10,
                            ),
                          ],
                        ),
                ),
              ),
              20.0.spaceY,
              LabelSmallText(
                title: LocaleKeys.userProfileDesc.tr(),
                titleColor: ColorConstants.blackColor,
                titleTextAlign: TextAlign.center,
                fontSize: 10,
                maxLine: 5,
                fontFamily: FontWeightEnum.w600.toInter,
              ),
              20.0.spaceY,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.borderLightColor, width: 1),
                    color: ColorConstants.yellowButtonColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.blackColor.withOpacity(0.10),
                        blurRadius: 2,
                        offset: Offset(1, 1),
                        spreadRadius: 0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => context.toPushNamed(RoutesConstants.paymentDetailsScreen),
                      child: ShadowContainer(
                        shadowColor: ColorConstants.blackColor.withOpacity(0.20),
                        backgroundColor: ColorConstants.yellowLightColor,
                        padding: EdgeInsets.zero,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                        border: 5,
                        child: LabelSmallText(
                          title: LocaleKeys.paymentDetail.tr(),
                          titleColor: ColorConstants.textColor,
                          titleTextAlign: TextAlign.center,
                          shadow: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                        ).addAllPadding(20),
                      ),
                    ),
                    InkWell(
                      onTap: () => context.toPushNamed(RoutesConstants.mirlConnectScreen),
                      child: ShadowContainer(
                        shadowColor: ColorConstants.blackColor.withOpacity(0.20),
                        backgroundColor: ColorConstants.mirlConnectColor,
                        padding: EdgeInsets.zero,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                        border: 5,
                        child: LabelSmallText(
                          title: LocaleKeys.mirlConnect.tr(),
                          titleColor: ColorConstants.textColor,
                          titleTextAlign: TextAlign.center,
                          shadow: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                        ).addAllPadding(20),
                      ),
                    ),
                    InkWell(
                      onTap: () => context.toPushNamed(RoutesConstants.helpAndTermsScreen),
                      child: ShadowContainer(
                        shadowColor: ColorConstants.blackColor.withOpacity(0.20),
                        backgroundColor: ColorConstants.yellowLightColor,
                        padding: EdgeInsets.zero,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                        border: 5,
                        child: LabelSmallText(
                          title: LocaleKeys.helpTerm.tr(),
                          titleColor: ColorConstants.textColor,
                          titleTextAlign: TextAlign.center,
                          shadow: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: ColorConstants.blackColor.withOpacity(0.25))],
                        ).addAllPadding(20),
                      ),
                    ),
                  ],
                ).addMarginY(20),
              ),
              40.0.spaceY,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleMediumText(
                    title: LocaleKeys.yourDetails.tr(),
                    titleColor: ColorConstants.blueColor,
                  ),
                  18.0.spaceY,
                  TextFormFieldWidget(
                    borderWidth: 1,
                    enabledBorderColor: ColorConstants.borderLightColor,
                    isReadOnly: true,
                    onTap: () {
                      userSettingRead.getUserSettingData();
                      context.toPushNamed(RoutesConstants.editYourNameScreen);
                    },
                    height: 30,
                    labelText: LocaleKeys.seekerName.tr(),
                    alignment: Alignment.centerLeft,
                    labelTextSpace: 0.0,
                    controller: userSettingWatch.userNameController,
                    //  controller: TextEditingController(text: userSettingWatch.userName),
                  ),
                  20.0.spaceY,
                  TextFormFieldWidget(
                    borderWidth: 1,
                    labelTextSpace: 0.0,
                    enabledBorderColor: ColorConstants.borderLightColor,
                    isReadOnly: true,
                    //onTap: () {
                    //context.toPushNamed(RoutesConstants.editYourEmailIdScreen);
                    //},
                    height: 30,
                    labelText: LocaleKeys.emailId.tr(),
                    alignment: Alignment.centerLeft,
                    controller: userSettingWatch.emailIdController,
                    //controller: TextEditingController(text: userSettingWatch.emailId),
                  ),
                  20.0.spaceY,
                  TextFormFieldWidget(
                    borderWidth: 1,
                    labelTextSpace: 0.0,
                    enabledBorderColor: ColorConstants.borderLightColor,
                    isReadOnly: true,
                    onTap: () {
                      userSettingRead.getUserSettingData();
                      context.toPushNamed(RoutesConstants.editYourPhoneNumberScreen);
                    },
                    height: 30,
                    labelText: LocaleKeys.phoneNumber.tr(),
                    alignment: Alignment.centerLeft,
                    controller: userSettingWatch.phoneNumberController,

                    //controller: TextEditingController(text: userSettingWatch.phoneNumber),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                      buttonColor: ColorConstants.buttonColor,
                      title: LocaleKeys.upcomingAppointment.tr(),
                      titleColor: ColorConstants.buttonTextColor,
                      onPressed: () => context.toPushNamed(RoutesConstants.viewCalendarAppointment, args: AppointmentArgs(role: 1))),
                  50.0.spaceY,
                  PrimaryButton(
                      buttonColor: ColorConstants.buttonColor,
                      title: LocaleKeys.notificationAndPreference.tr(),
                      titleColor: ColorConstants.buttonTextColor,
                      onPressed: () => context.toPushNamed(RoutesConstants.notificationAndPreferencesScreen)),
                  50.0.spaceY,
                  PrimaryButton(
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.reportAndIssue.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    onPressed: () => context.toPushNamed(RoutesConstants.reportAnIssueScreen),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.callHistoryAndBilling.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                   onPressed: () => context.toPushNamed(RoutesConstants.seekerCallHistoryScreen),
                  //  onPressed: () => context.toPushNamed(RoutesConstants.callFeedbackScreen, args: 8),
                  ),
                  50.0.spaceY,
                  PrimaryButton(
                    buttonColor: ColorConstants.buttonColor,
                    title: LocaleKeys.signOut.tr(),
                    titleColor: ColorConstants.buttonTextColor,
                    onPressed: () {
                      userSettingRead.UserLogoutApiCall(context: context);
                    },
                  ),
                  50.0.spaceY,
                ],
              ).addMarginX(20),
            ],
          ).addAllPadding(20),
        ));
  }
}
