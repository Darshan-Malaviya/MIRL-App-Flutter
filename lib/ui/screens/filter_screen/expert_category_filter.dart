import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';

class ExpertCategoryFilterScreen extends ConsumerStatefulWidget {
  const ExpertCategoryFilterScreen({super.key});

  @override
  ConsumerState createState() => _ExpertCategoryFilterScreenState();
}

class _ExpertCategoryFilterScreenState extends ConsumerState<ExpertCategoryFilterScreen> {
  double start = 30;
  double end = 50;

  @override
  Widget build(BuildContext context) {
    final filterWatch = ref.watch(filterProvider);
    final filterRead = ref.read(filterProvider);

    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleLargeText(
              title: StringConstants.expertCategoryFilter,
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ),
            10.0.spaceY,
            BodySmallText(
              title: StringConstants.selectedCategory,
              titleColor: ColorConstants.bottomTextColor,
            ),
            5.0.spaceY,
            BodyMediumText(
              title: 'Mentor',
            ),
            10.0.spaceY,
            BodySmallText(
              title: StringConstants.pickTopicFromTheAbove,
            ),
            30.0.spaceY,
            DropdownMenuWidget(
              hintText: StringConstants.selectOnrOrLeave,
              controller: filterWatch.instantCallAvailabilityController,
              dropdownList: filterWatch.yesNoSelectionList.map((String item) => dropdownMenuEntry(context: context, value: item, label: item)).toList(),
              onSelect: filterRead.setValueOfCall,
            ),
            30.0.spaceY,
            DropdownMenuWidget(
              controller: filterWatch.genderController,
              hintText: StringConstants.selectOnrOrLeave,
              dropdownList: filterWatch.ratingList.map((item) => dropdownMenuEntry(context: context, value: item, label: item)).toList(),
              labelText: StringConstants.overallRatting,
              lableColor: ColorConstants.bottomTextColor,
              onSelect: filterRead.setRating,
            ),
            30.0.spaceY,
            DropdownMenuWidget(
              controller: filterWatch.genderController,
              hintText: StringConstants.selectOnrOrLeave,
              dropdownList: filterWatch.genderList.map((GenderModel item) => dropdownMenuEntry(context: context, value: item.title ?? '', label: item.title ?? '')).toList(),
              onSelect: filterRead.setGender,
              labelText: StringConstants.setYourGender,
              lableColor: ColorConstants.bottomTextColor,
            ),
            20.0.spaceY,
            RangeSlider(
              values: RangeValues(start, end),
              activeColor: ColorConstants.yellowButtonColor,
              inactiveColor: ColorConstants.lineColor,
              divisions: 25,
              onChanged: (value) {
                setState(() {
                  start = value.start;
                  end = value.end;
                });
              },
              min: 0,
              max: 100,
            ),
            Text(
              "Start: " + start.toStringAsFixed(2) + "\nEnd: " + end.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 32.0,
              ),
            ),
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
