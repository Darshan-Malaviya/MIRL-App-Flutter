import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class StartCallWidget extends ConsumerWidget {
  const StartCallWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        30.0.spaceY,
        PrimaryButton(
          height: 55,
          title: LocaleKeys.startVideoCall.tr(),
          margin: EdgeInsets.symmetric(horizontal: 10),
          fontSize: 15,
          onPressed: () {},
        ),
        10.0.spaceY,
        BodyMediumText(
          title: LocaleKeys.paymentCompleted.tr(),
          fontFamily: FontWeightEnum.w500.toInter,
          titleColor: ColorConstants.buttonTextColor,
          titleTextAlign: TextAlign.center,
        )
      ],
    );
  }
}
