import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SetYourWeeklyAvailabilityScreen extends ConsumerStatefulWidget {
  const SetYourWeeklyAvailabilityScreen({super.key});

  @override
  ConsumerState<SetYourWeeklyAvailabilityScreen> createState() => _DetYourWeeklyAvailabilityScreenState();
}

class _DetYourWeeklyAvailabilityScreenState extends ConsumerState<SetYourWeeklyAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          trailingIcon: TitleMediumText(
            title: StringConstants.done,
            fontFamily: FontWeightEnum.w700.toInter,
          ).addPaddingRight(14),
        ),
        body: Column(
          
          children: [
            TitleLargeText(
              title: StringConstants.weeklyAvailability,
              titleColor: ColorConstants.bottomTextColor,
              fontFamily: FontWeightEnum.w700.toInter,
            ),
          ],
        ).addAllPadding(10));
  }
}
