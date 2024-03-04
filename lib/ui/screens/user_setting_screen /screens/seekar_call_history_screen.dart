import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_call_history_screen/widget/expert_call_history_widget.dart';

class SeekerCallHistoryScreen extends ConsumerStatefulWidget {
  const SeekerCallHistoryScreen({super.key});

  @override
  ConsumerState<SeekerCallHistoryScreen> createState() => _SeekerCallHistoryScreenState();
}

class _SeekerCallHistoryScreenState extends ConsumerState<SeekerCallHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Column(
        children: [
          TitleLargeText(
            title: LocaleKeys.seekerCallHistory.tr(),
            titleColor: ColorConstants.bottomTextColor,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          TitleSmallText(
            title: "NOVEMBER 2023",
            titleColor: ColorConstants.buttonTextColor,
            titleTextAlign: TextAlign.center,
          ),
          10.0.spaceY,
          Image.asset(ImageConstants.purpleLine),
          40.0.spaceY,
          ExpertCallHistoryWidget(
            role: 2,
          )
        ],
      ).addAllPadding(20),
    );
  }
}
