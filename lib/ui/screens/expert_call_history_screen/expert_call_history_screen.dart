import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_call_history_screen/widget/expert_call_history_widget.dart';

class ExpertCallHistoryScreen extends ConsumerStatefulWidget {
  const ExpertCallHistoryScreen({super.key});

  @override
  ConsumerState<ExpertCallHistoryScreen> createState() => _ExpertCallHistoryScreenState();
}

class _ExpertCallHistoryScreenState extends ConsumerState<ExpertCallHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: OnScaleTap(
          onPress: () {
            // if (_loginPassKey.currentState?.validate() ?? false) {
            // }
          },
          child: TitleMediumText(
            title: StringConstants.done,
            fontFamily: FontWeightEnum.w700.toInter,
          ).addPaddingRight(14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleLargeText(
              title: LocaleKeys.expertCallHistory.tr(),
              titleColor: ColorConstants.bottomTextColor,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            TitleSmallText(
              title: "NOVEMBER 2023",
              titleColor: ColorConstants.buttonTextColor,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            Image.asset(ImageConstants.purpleLine),
            40.0.spaceY,
            ExpertCallHistoryWidget(
              bgColor: ColorConstants.categoryList,
              userTitle: 'PREETI',
              callTitle: 'INSTANT CALL',
              number: '10',
              minutes: '03:30PM',
              callTime: 'PAYMENT COMPLETE',
              status: 'INCOMPLETE',
              statusColor: ColorConstants.disableColor,
              durationTime: '20',
            ),
            20.0.spaceY,
            ExpertCallHistoryWidget(
              userTitle: 'PREETI',
              callTitle: 'INSTANT CALL',
              number: '10',
              minutes: '03:30PM',
              callTime: 'PAYMENT COMPLETE',
              status: 'COMPLETE',
              durationTime: '20',

            )
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
