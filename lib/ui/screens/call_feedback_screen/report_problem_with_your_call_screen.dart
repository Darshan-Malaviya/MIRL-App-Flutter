import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/report_call_title_response_model.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class ReportProblemWithYourCallScreen extends ConsumerStatefulWidget {
  final int callHistoryId;

  const ReportProblemWithYourCallScreen({super.key, required this.callHistoryId});

  @override
  ConsumerState<ReportProblemWithYourCallScreen> createState() => _ReportProblemWithYourCallScreenState();
}

class _ReportProblemWithYourCallScreenState extends ConsumerState<ReportProblemWithYourCallScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(reportReviewProvider).clearController();
      await ref.read(reportReviewProvider).getReportCallTitleApiCall();
    });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
                hintText: StringConstants.theDropDown,
                dropdownList: feedBackWatch.reportCallTitleList
                    .map((value) => dropdownMenuEntry(context: context, label: value.title ?? '', value: value.description ?? ''))
                    .toList(),
                onSelect: (newValue) {
                  feedBackRead.setReportCallTitle(feedBackWatch.selectedReportCall);
                },
              ),

              30.0.spaceY,
              DropdownButtonFormField<ReportCallTitleList>(
                isDense: false,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                //    underline: SizedBox.shrink(),
                decoration: InputDecoration(
                    // focusColor: ColorConstants.dropDownBorderColor,
                    // border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: ColorConstants.dropDownBorderColor, width: 1),
                )),
                hint: BodySmallText(
                  title: LocaleKeys.appropriateIssue.tr(),
                  titleColor: ColorConstants.buttonTextColor,
                  fontFamily: FontWeightEnum.w400.toInter,
                ).addMarginX(10),
                itemHeight: 66,
                value: feedBackWatch.selectedReportCall,
                isExpanded: true,
                padding: EdgeInsets.only(right: 6, left: 6, top: 10),
                items: feedBackWatch.reportCallTitleList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodySmallText(
                          title: value.title ?? '',
                          titleColor: ColorConstants.buttonTextColor,
                        ),
                        4.0.spaceY,
                        BodySmallText(
                          title: value.description ?? '',
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.buttonTextColor,
                          maxLine: 4,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  feedBackRead.setReportCallTitle(newValue ?? null);
                },
                validator: (value) => value == null ? LocaleKeys.filedRequired.tr() : null,
              ).addMarginX(10),
              // ),
              // DropdownMenuWidget(
              //   hintText: LocaleKeys.appropriateIssue.tr(),
              //   controller: feedBackWatch.appropriateIssueController,
              //   dropdownList: feedBackWatch.callIssue
              //       .map((ReportCallTitleList item) =>
              //           dropdownMenuEntry(context: context, value: item.title ?? '', label: item.description ?? ''))
              //       .toList(),
              //   onSelect: (String value) {
              //     feedBackRead.setReportCallTitle(value);
              //   },
              // ),
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
                  // ref.read(reportReviewProvider).clearController();
                  // await ref.read(reportReviewProvider).getReportCallTitleApiCall();
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate() && feedBackWatch.callIssueController.text.isNotEmpty) {
                    feedBackRead.reportCallApiCall(callHistoryId: widget.callHistoryId);
                  } else {
                    FlutterToast().showToast(msg: LocaleKeys.selectThisIssue.tr());
                  }
                },
              ),
            ],
          ).addAllPadding(20),
        ),
      ),
    );
  }
}
