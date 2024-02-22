import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class CanceledAppointmentOptionScreen extends ConsumerStatefulWidget {
  final CancelArgs args;

  const CanceledAppointmentOptionScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _CanceledAppointmentOptionScreenState();
}

class _CanceledAppointmentOptionScreenState extends ConsumerState<CanceledAppointmentOptionScreen> {
  final _loginPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cancelWatch = ref.watch(cancelAppointmentProvider);
    final cancelRead = ref.read(cancelAppointmentProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Form(
        key: _loginPassKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.0.spaceY,
              Center(
                child: TitleLargeText(
                  title: LocaleKeys.sureYouWantCancel.tr(),
                  titleColor: ColorConstants.bottomTextColor,
                  titleTextAlign: TextAlign.center,
                  maxLine: 2,
                ),
              ),
              20.0.spaceY,
              PrimaryButton(
                title: LocaleKeys.retainAppointment.tr(),
                onPressed: () {
                  context.toPop();
                },
                fontSize: 15,
              ),
              30.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.reasonForCanceledAppointment.tr(),
                titleColor: ColorConstants.buttonTextColor,
              ),
              5.0.spaceY,
              BodyMediumText(
                title: LocaleKeys.cancelReasonDescription.tr(),
                titleColor: ColorConstants.buttonTextColor,
                fontFamily: FontWeightEnum.w400.toInter,
                maxLine: 3,
                titleTextAlign: TextAlign.center,
              ).addMarginX(20),
              20.0.spaceY,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextFormFieldWidget(
                    onChanged: cancelRead.setReasonLength,
                    maxLines: 10,
                    maxLength: 500,
                    minLines: 8,
                    controller: cancelWatch.reasonController,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    canRequestFocus: !(cancelWatch.isLoadingReason ?? false),
                    contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
                    borderRadius: 25,
                    validator: (value) {
                      return value?.toEmptyStringValidation(msg: LocaleKeys.reasonRequired.tr());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 12),
                    child: BodySmallText(
                      title: '${cancelWatch.reasonTextLength}/500 ${LocaleKeys.characters.tr()}',
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleColor: ColorConstants.buttonTextColor,
                    ),
                  ),
                ],
              ),
              30.0.spaceY,
              PrimaryButton(
                title: LocaleKeys.yesGoToCanceled.tr(),
                buttonColor: ColorConstants.buttonColor,
                isLoading: cancelWatch.isLoadingReason,
                onPressed: () {
                  if (_loginPassKey.currentState?.validate() ?? false) {
                    cancelRead.cancelAppointmentApiCall(
                      context: context,
                      appointmentData: widget.args.appointmentData,
                      role: widget.args.role ?? 1,
                      fromScheduled: widget.args.fromScheduled ?? false,
                    );
                  }
                },
                fontSize: 15,
              ),
            ],
          ).addPaddingX(20),
        ),
      ),
    );
  }
}
