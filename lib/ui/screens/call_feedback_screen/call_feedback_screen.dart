import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CallFeedbackScreen extends ConsumerStatefulWidget {
  const CallFeedbackScreen({super.key});

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
              BodySmallText(
                title: LocaleKeys.issueWithCall.tr(),
                titleColor: ColorConstants.darkRedColor,
                fontFamily: FontWeightEnum.w400.toInter,
              ),
              40.0.spaceY,
              Image.asset(ImageConstants.line, color: ColorConstants.primaryColor),
              30.0.spaceY,
              TitleLargeText(title: LocaleKeys.howWouldYouRate.tr(), fontSize: 18, titleColor: ColorConstants.buttonTextColor),
              10.0.spaceY,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  feedBackWatch.feedbackTypeList.length,
                  (index) => Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(feedBackWatch.feedbackTypeList[index].value ?? ''),
                      10.0.spaceY,
                      LabelSmallText(
                        title: '${feedBackWatch.feedbackTypeList[index].title ?? ''}',
                        fontSize: 10,
                      ).addMarginBottom(3),
                    ],
                  ).addMarginLeft(10),
                ),
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
                onPressed: () => context.toPushNamed(RoutesConstants.feedbackSubmittingScreen)
              ),
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
