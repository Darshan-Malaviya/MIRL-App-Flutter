import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class CanceledAppointmentOptionScreen extends ConsumerWidget {
  const CanceledAppointmentOptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleWatch = ref.read(scheduleCallProvider);
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
            10.0.spaceY,
            BodyMediumText(
              title: LocaleKeys.cancelReasonDescription.tr(),
              titleColor: ColorConstants.buttonTextColor,
              fontFamily: FontWeightEnum.w400.toInter,
              maxLine: 3,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                TextFormFieldWidget(
                  onChanged: (value) {},
                  maxLines: 10,
                  maxLength: 500,
                  minLines: 8,
                  controller: scheduleWatch.reasonController,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 12),
                  child: BodySmallText(
                    title: '${0}/500 ${LocaleKeys.characters.tr()}',
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
              onPressed: () {
                context.toPushNamed(RoutesConstants.canceledAppointmentScreen);
              },
              fontSize: 15,
            ),
          ],
        ).addPaddingX(20),
      ),
    );
  }
}
