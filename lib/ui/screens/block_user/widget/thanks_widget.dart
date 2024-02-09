import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ThanksWidget extends ConsumerStatefulWidget {
  const ThanksWidget({super.key});

  @override
  ConsumerState<ThanksWidget> createState() => _ThanksWidgetState();
}

class _ThanksWidgetState extends ConsumerState<ThanksWidget> {
  @override
  Widget build(BuildContext context) {
    final reportUserRead = ref.read(reportUserProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        60.0.spaceY,
        TitleLargeText(
          title: LocaleKeys.thanks.tr(),
          titleColor: ColorConstants.bottomTextColor,
          titleTextAlign: TextAlign.center,
        ),
        30.0.spaceY,
        BodyLargeText(
          title: LocaleKeys.bringing.tr(),
          titleColor: ColorConstants.blackColor,
          titleTextAlign: TextAlign.center,
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 3,
        ),
        20.0.spaceY,
        BodyLargeText(
          title: LocaleKeys.maintaining.tr(),
          titleColor: ColorConstants.blackColor,
          titleTextAlign: TextAlign.center,
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 10,
        ),
        100.0.spaceY,
        PrimaryButton(
          title: LocaleKeys.back.tr(),
          titleColor: ColorConstants.buttonTextColor,
          onPressed: () {
            reportUserRead.thanks();
          },
        ),
      ],
    ).addAllPadding(20);
  }
}
