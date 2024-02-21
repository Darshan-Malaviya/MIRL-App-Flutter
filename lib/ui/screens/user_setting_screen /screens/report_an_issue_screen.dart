import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class ReportAnIssueScreen extends ConsumerStatefulWidget {
  const ReportAnIssueScreen({super.key});

  @override
  ConsumerState<ReportAnIssueScreen> createState() => _ReportAnIssueScreenState();
}

class _ReportAnIssueScreenState extends ConsumerState<ReportAnIssueScreen> {
  List<String> _locations = ["Yes", "No"];

  List<String> get locations => _locations;

  @override
  Widget build(BuildContext context) {
    final userSettingWatch = ref.watch(userSettingProvider);
    final userSettingRead = ref.read(userSettingProvider);
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
            children: [
              30.0.spaceY,
              TitleLargeText(
                title: LocaleKeys.reportAndIssue.tr(),
                titleColor: ColorConstants.bottomTextColor,
                titleTextAlign: TextAlign.center,
              ),
              20.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.experiencing.tr(),
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              40.0.spaceY,
              DropdownMenuWidget(
                hintText: LocaleKeys.theDropdown.tr(),
                // controller: expertWatch.locationController,
                dropdownList:
                    locations.map((String item) => dropdownMenuEntry(context: context, value: item, label: item)).toList(),
                onSelect: (String value) {
                  //   expertWatch.locationSelect(value);
                },
              ),
              40.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.tellUsMore.tr(),
                titleColor: ColorConstants.buttonTextColor,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              BodyMediumText(
                title: LocaleKeys.planned.tr(),
                titleColor: ColorConstants.buttonTextColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              20.0.spaceY,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    //padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: ShapeDecoration(
                      color: ColorConstants.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25),
                          blurRadius: 4,
                          offset: Offset(-4, -4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: TextFormFieldWidget(
                      onChanged: userSettingWatch.changeAboutCounterValue,
                      maxLines: 10,
                      maxLength: 500,
                      minLines: 8,
                      enabledBorderColor: ColorConstants.transparentColor,
                      controller: userSettingWatch.reasonController,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      setFormatter: false,
                      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 12),
                    child: BodySmallText(
                      title: '${userSettingWatch.enteredText}/500 ${LocaleKeys.characters.tr()}',
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ],
              ),
              50.0.spaceY,
              PrimaryButton(
                height: 45,
                buttonColor: ColorConstants.buttonColor,
                title: LocaleKeys.reportIssue.tr(),
                titleColor: ColorConstants.buttonTextColor,
                fontSize: 15,
                onPressed: () {},
                // onPressed: () => context.toPushNamed(RoutesConstants.earningReportScreen),
              ),
            ],
          ).addAllPadding(20),
        ));
  }
}
