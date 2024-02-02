import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class InstantCallsAvailabilityScreen extends ConsumerStatefulWidget {
  const InstantCallsAvailabilityScreen({super.key});

  @override
  ConsumerState<InstantCallsAvailabilityScreen> createState() => _InstantCallsAvailabilityScreenState();
}

class _InstantCallsAvailabilityScreenState extends ConsumerState<InstantCallsAvailabilityScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    return Scaffold(
      appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
          trailingIcon: InkWell(
            onTap: () {
              expertRead.updateInstantCallApi();
            },
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleLargeText(
              title: StringConstants.instantCallsAvailability,
              titleColor: ColorConstants.bottomTextColor,
              fontFamily: FontWeightEnum.w700.toInter,
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ),
            20.0.spaceY,
            TitleMediumText(
              title: StringConstants.availabilitySchedule,
              fontFamily: FontWeightEnum.w700.toInter,
              titleTextAlign: TextAlign.center,
              maxLine: 3,
              fontSize: 15,
            ),
            20.0.spaceY,
            DropdownMenuWidget(
              hintText: StringConstants.theDropDown,
              controller: expertWatch.instantCallAvailabilityController,
              dropdownList: expertWatch.locations
                  .map((String item) => dropdownMenuEntry(context: context, value: item, label: item))
                  .toList(),
              onSelect: (value) {
                expertWatch.setValueOfCall(value);
              },
            ),
            40.0.spaceY,
            TitleSmallText(
              fontFamily: FontWeightEnum.w400.toInter,
              title: StringConstants.instantCalls,
              maxLine: 2,
            ),
            20.0.spaceY,
            TitleSmallText(
              fontFamily: FontWeightEnum.w400.toInter,
              title: StringConstants.declineAnyCall,
              maxLine: 2,
            ),
            20.0.spaceY,
            TitleSmallText(
              fontFamily: FontWeightEnum.w400.toInter,
              title: StringConstants.highlyRecommend,
            )
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
