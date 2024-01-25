import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/edit_profile/widget/set_week_time_widget.dart';

class SetYourWeeklyAvailabilityScreen extends ConsumerStatefulWidget {
  const SetYourWeeklyAvailabilityScreen({super.key});

  @override
  ConsumerState<SetYourWeeklyAvailabilityScreen> createState() => _DetYourWeeklyAvailabilityScreenState();
}

class _DetYourWeeklyAvailabilityScreenState extends ConsumerState<SetYourWeeklyAvailabilityScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).generateWeekDaysTime();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
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
              expertRead.expertAvailabilityApi(context, _tabController?.index == 0 ? '1' : '2');
            },
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          ),
        ),
        body: Column(
          children: [
            TitleLargeText(
              title: StringConstants.weeklyAvailability,
              titleColor: ColorConstants.bottomTextColor,
              fontFamily: FontWeightEnum.w700.toInter,
              titleTextAlign: TextAlign.center,
              maxLine: 2,
            ),
            20.0.spaceY,
            SizedBox(
              height: 35,
              width: MediaQuery.sizeOf(context).width / 1.2,
              child: Container(
                decoration: BoxDecoration(color: ColorConstants.categoryList, borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  overlayColor: MaterialStatePropertyAll(ColorConstants.transparentColor),
                  controller: _tabController,
                  indicator: BoxDecoration(color: ColorConstants.primaryColor, borderRadius: BorderRadius.circular(25.0)),
                  dividerColor: ColorConstants.transparentColor,
                  labelColor: ColorConstants.blackColor,
                  unselectedLabelColor: ColorConstants.blackColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: FontWeightEnum.w700.toInter, fontSize: 14),
                  onTap: expertRead.getTabIndex,
                  tabs: [
                    Tab(
                      text: StringConstants.recurring,
                    ),
                    Tab(text: StringConstants.nonRecurring),
                  ],
                ),
              ),
            ),
            10.0.spaceY,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: ShapeDecoration(
                        color: expertWatch.tabIndex == 0 ? ColorConstants.primaryColor : ColorConstants.categoryList,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: Center(
                      child: BodyMediumText(
                        title: StringConstants.followedEveryWeek,
                        fontFamily: FontWeightEnum.w400.toInter,
                        maxLine: 5,
                      ).addMarginX(10),
                    ),
                  ),
                ),
                16.0.spaceX,
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: ShapeDecoration(
                        color: expertWatch.tabIndex == 1 ? ColorConstants.primaryColor : ColorConstants.categoryList,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: Center(
                      child: BodyMediumText(
                        title: StringConstants.manuallyEveryWeek,
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleTextAlign: TextAlign.center,
                        maxLine: 5,
                      ).addMarginX(10),
                    ),
                  ),
                )
              ],
            ),
            20.0.spaceY,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [SetWeekTimeWidget(), SetWeekTimeWidget()],
              ),
            ),
          ],
        ).addAllPadding(10));
  }
}
