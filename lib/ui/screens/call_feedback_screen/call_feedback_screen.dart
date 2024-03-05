import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/call_feedback_screen/widget/review_rating_widget.dart';

class CallFeedbackScreen extends ConsumerStatefulWidget {
  final int callHistoryId;

  const CallFeedbackScreen({super.key, required this.callHistoryId});

  @override
  ConsumerState createState() => _CallFeedbackScreenState();
}

class _CallFeedbackScreenState extends ConsumerState<CallFeedbackScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      OpenDialog(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedBackWatch = ref.watch(reportReviewProvider);
    final feedBackRead = ref.read(reportReviewProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(
          preferSize: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              20.0.spaceY,
              TitleLargeText(
                title: LocaleKeys.yourCallCompleted.tr(),
                titleColor: ColorConstants.bottomTextColor,
              ),
              20.0.spaceY,
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: FontWeightEnum.w400.toInter, fontSize: 16, height: 1.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: LocaleKeys.doYouWantToRequest.tr(),
                        style: TextStyle(
                          color: ColorConstants.blackColor,
                        )),
                    TextSpan(
                      text: LocaleKeys.instantCall.tr(),
                      style: TextStyle(
                        color: ColorConstants.bottomTextColor,
                      ),
                    ),
                    TextSpan(
                      text: LocaleKeys.yourConsultationIsComplete.tr(),
                      style: TextStyle(
                        color: ColorConstants.blackColor,
                      ),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              20.0.spaceY,
              InkWell(
                onTap: () {
                  context.toPushNamed(RoutesConstants.reportProblemWithYourCallScreen,args: widget.callHistoryId);
                },
                child: BodySmallText(
                  title: LocaleKeys.issueWithCall.tr(),
                  titleColor: ColorConstants.darkRedColor,
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ),
              40.0.spaceY,
              Image.asset(ImageConstants.line, color: ColorConstants.primaryColor),
              30.0.spaceY,
              TitleLargeText(title: LocaleKeys.howWouldYouRate.tr(), fontSize: 18, titleColor: ColorConstants.buttonTextColor),
              10.0.spaceY,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    feedBackWatch.feedbackTypeList.length,
                    (index) => InkWell(
                          onTap: () {
                            feedBackRead.onSelectedCategory(index: index);
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ShadowContainer(
                                    shadowColor: feedBackWatch.feedbackTypeList[index].isSelected ?? false
                                        ? ColorConstants.primaryColor
                                        : ColorConstants.transparentColor,
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    child: SizedBox.shrink(),
                                    height: 72,
                                    width: 60,
                                    isShadow: true,
                                  ),
                                  10.0.spaceY,
                                  Image.asset(feedBackWatch.feedbackTypeList[index].value ?? ''),
                                  10.0.spaceY,
                                  LabelSmallText(
                                    title: '${feedBackWatch.feedbackTypeList[index].title ?? ''}',
                                    fontSize: 10,
                                  ).addMarginBottom(3),
                                ],
                              ),
                            ],
                          ),
                        )),
              ),
              40.0.spaceY,
              Image.asset(ImageConstants.line, color: ColorConstants.primaryColor),
              30.0.spaceY,
              BodyLargeText(
                title: LocaleKeys.howWouldYouRateExpert.tr(),
                titleColor: ColorConstants.buttonTextColor,
                titleTextAlign: TextAlign.start,
                maxLine: 3,
              ),
              20.0.spaceY,
              Column(
                  children: List.generate(feedBackWatch.criteriaList.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyLargeText(
                      title: feedBackWatch.criteriaList[index].title ?? '',
                      titleColor: ColorConstants.buttonTextColor,
                      titleTextAlign: TextAlign.start,
                      maxLine: 3,
                      fontSize: 15,
                    ),
                    BodyLargeText(
                      title: feedBackWatch.criteriaList[index].value ?? '',
                      titleColor: ColorConstants.buttonTextColor,
                      titleTextAlign: TextAlign.start,
                      maxLine: 3,
                      fontSize: 15,
                      fontFamily: FontWeightEnum.w400.toInter,
                    ),
                    4.0.spaceY,
                    ReviewRatingWidget(index: index),
                  ],
                ).addMarginY(10);
              })),
              40.0.spaceY,
              BodyMediumText(title: LocaleKeys.leaveAReview.tr(), titleColor: ColorConstants.buttonTextColor),
              10.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.howWasYourExperience.tr(),
                titleColor: ColorConstants.buttonTextColor,
                fontFamily: FontWeightEnum.w400.toInter,
                maxLine: 3,
              ),
              20.0.spaceY,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextFormFieldWidget(
                    hintTextColor: ColorConstants.buttonTextColor,
                    maxLines: 20,
                    maxLength: 1000,
                    minLines: 10,
                    controller: feedBackWatch.reviewController,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    contentPadding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 30),
                    borderRadius: 25,
                    borderWidth: 0,
                    enabledBorderColor: ColorConstants.transparentColor,
                    fillColor: ColorConstants.transparentColor,
                    focusedBorderColor: ColorConstants.transparentColor,
                    enableShadow: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 12),
                    child: BodySmallText(
                      title: '${feedBackWatch.reviewController.text.length}/1000 ${LocaleKeys.characters.tr()}',
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ],
              ),
              40.0.spaceY,
              PrimaryButton(
                  title: LocaleKeys.shareSuggestion.tr(),
                  titleColor: ColorConstants.buttonTextColor,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    feedBackRead.rateExpertRequestCall(callHistoryId: widget.callHistoryId);
                  }),
            ],
          ).addAllMargin(20),
        ),
      ),
    );
  }

  void OpenDialog(BuildContext context) {
    CommonAlertDialog.dialog(
      context: context,
      borderRadius: 15,
      bgColor: ColorConstants.whiteColor,
      barrierDismissible: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BodyLargeText(
            title: LocaleKeys.noFeedback.tr(),
            fontFamily: FontWeightEnum.w600.toInter,
            titleColor: ColorConstants.bottomTextColor,
            fontSize: 17,
          ),
          10.0.spaceY,
          BodyLargeText(
            title: LocaleKeys.quickFeedback.tr(),
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
            maxLine: 5,
          ),
          30.0.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OnScaleTap(
                onPress: () => context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0),
                child: BodyLargeText(
                  title: LocaleKeys.yes.tr().toUpperCase(),
                  fontFamily: FontWeightEnum.w500.toInter,
                  titleColor: ColorConstants.bottomTextColor,
                  fontSize: 17,
                ),
              ),
              16.0.spaceX,
              OnScaleTap(
                onPress: () => context.toPop(),
                child: BodyLargeText(
                  title: LocaleKeys.no.tr().toUpperCase(),
                  fontFamily: FontWeightEnum.w500.toInter,
                  titleColor: ColorConstants.bottomTextColor,
                  fontSize: 17,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
