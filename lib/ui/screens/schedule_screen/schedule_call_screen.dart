import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/screens/schedule_screen/widget/weekly_availability.dart';

class ScheduleCallScreen extends ConsumerStatefulWidget {
  final CallArgs callArgs;

  const ScheduleCallScreen({super.key, required this.callArgs});

  @override
  ConsumerState createState() => _ScheduleCallScreenState();
}

class _ScheduleCallScreenState extends ConsumerState<ScheduleCallScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(scheduleCallProvider).expertAvailabilityApi(widget.callArgs.expertId ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
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
            TitleLargeText(title: LocaleKeys.scheduleCall.tr(), fontSize: 20, fontWeight: FontWeight.w700),
            22.0.spaceY,
            //NoWeeklyAvailability(),
            WeeklyAvailability()
          ],
        ),
      ),
    );
  }
}
