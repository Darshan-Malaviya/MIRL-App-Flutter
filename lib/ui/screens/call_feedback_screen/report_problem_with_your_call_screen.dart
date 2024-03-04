import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class ReportProblemWithYourCallScreen extends ConsumerStatefulWidget {
  const ReportProblemWithYourCallScreen({super.key});

  @override
  ConsumerState<ReportProblemWithYourCallScreen> createState() => _ReportProblemWithYourCallScreenState();
}

class _ReportProblemWithYourCallScreenState extends ConsumerState<ReportProblemWithYourCallScreen> {
  @override
  Widget build(BuildContext context) {
    final feedBackWatch = ref.watch(reportReviewProvider);
    final feedBackRead = ref.read(reportReviewProvider);
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleSmallText(
              title: LocaleKeys.callProblem.tr(),
              titleColor: ColorConstants.buttonTextColor,
            ),
            10.0.spaceY,
            TitleSmallText(
              title: LocaleKeys.elaborate.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.buttonTextColor,
              maxLine: 5,
            ),
            20.0.spaceY,
            TitleSmallText(
              title: LocaleKeys.selectTheIssue.tr(),
              titleTextAlign: TextAlign.center,
              titleColor: ColorConstants.bottomTextColor,
              maxLine: 4,
            ),
            20.0.spaceY,
            DropdownMenuWidget(
              hintText: LocaleKeys.appropriateIssue.tr(),
              controller: feedBackWatch.appropriateIssueController,
              dropdownList: feedBackWatch.callIssue
                  .map((String item) => dropdownMenuEntry(context: context, value: item, label: item))
                  .toList(),
              onSelect: (String value) {},
            ),
            80.0.spaceY,
            TitleSmallText(
              title: LocaleKeys.facedBelow.tr(),
              fontFamily: FontWeightEnum.w400.toInter,
              titleTextAlign: TextAlign.start,
              titleColor: ColorConstants.buttonTextColor,
              maxLine: 2,
            ),
            10.0.spaceY,
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                TextFormFieldWidget(
                  onChanged: feedBackRead.newTopicCounterValue,
                  maxLines: 10,
                  maxLength: 500,
                  minLines: 8,
                  controller: feedBackWatch.callIssueController,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  contentPadding: EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 30),
                  borderRadius: 25,
                  borderWidth: 0,
                  enabledBorderColor: ColorConstants.transparentColor,
                  fillColor: ColorConstants.transparentColor,
                  enableShadow: true,
                  focusedBorderColor: ColorConstants.transparentColor,
                  onFieldSubmitted: (value) {
                    context.unFocusKeyboard();
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodySmallText(
                        title: 'CALL DROPPED',
                        titleColor: ColorConstants.buttonTextColor,
                      ),
                      BodySmallText(
                        title: 'An unexpected end of the call due to technical issues like network problems or app errors.',
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleColor: ColorConstants.buttonTextColor,
                        maxLine: 4,
                      ),
                      20.0.spaceY,
                      BodySmallText(
                        title: 'CALL DISCONNECTED ',
                        titleColor: ColorConstants.buttonTextColor,
                      ),
                      BodySmallText(
                        title: 'The call was ended intentionally or due to issues like battery drainage or time limits.',
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleColor: ColorConstants.buttonTextColor,
                        maxLine: 4,
                      ),
                    ],
                  ),
                ).addMarginXY(marginX: 20, marginY: 50),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 12),
                  child: BodySmallText(
                    title: '${feedBackWatch.enteredText}/500 ${LocaleKeys.characters.tr()}',
                    fontFamily: FontWeightEnum.w400.toInter,
                    titleColor: ColorConstants.buttonTextColor,
                  ),
                ),
              ],
            ),
            40.0.spaceY,
            PrimaryButton(
              title: LocaleKeys.reportIssue.tr(),
              onPressed: () {
                context.toPushNamed(RoutesConstants.reportedSubmittingScreen);
              },
            )
          ],
        ).addAllMargin(20),
      ),
    );
  }
}
