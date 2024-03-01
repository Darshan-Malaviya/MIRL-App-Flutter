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
        centerTitle: true,
        appTitle: TitleLargeText(
          title: LocaleKeys.expertCallHistory.tr(),
          titleColor: ColorConstants.bottomTextColor,
          titleTextAlign: TextAlign.center,
        ),
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleSmallText(
              title: "NOVEMBER 2023",
              //toDisplayMonthWithYear()
              titleColor: ColorConstants.buttonTextColor,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            Image.asset(ImageConstants.purpleLine),
            40.0.spaceY,
            ExpertCallHistoryWidget(),
            20.0.spaceY,
            ExpertCallHistoryWidget()
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
