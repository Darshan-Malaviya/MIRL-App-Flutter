import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/models/response/expert_category_response_model.dart';
import 'package:mirl/infrastructure/providers/filter_provider.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:mirl/ui/screens/edit_profile/widget/city_list_bottom_view.dart';
import 'package:mirl/ui/screens/edit_profile/widget/coutry_list_bottom_view.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_args.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_bottomsheet_widget.dart';

class ExpertCategoryFilterScreen extends ConsumerStatefulWidget {
  final FilterArgs args;

  const ExpertCategoryFilterScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _ExpertCategoryFilterScreenState();
}

class _ExpertCategoryFilterScreenState extends ConsumerState<ExpertCategoryFilterScreen> {
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.0.spaceY,
                BodySmallText(
                  title: StringConstants.selectedCategory,
                  titleColor: ColorConstants.bottomTextColor,
                ),
                5.0.spaceY,
                BodyMediumText(
                  title: 'Mentor'.toUpperCase(),
                ),
              ],
            ).addVisibility(!(widget.args.fromExploreExpert ?? false)),
            buildTextFormFieldWidget(filterWatch.topicController, context, () {
            /*  List<TopicData> topicList = [];
              topicList.addAll(widget.args.list ?? []);
              topicList.insert(0, TopicData(name: 'SELECT ONE OR LEAVE AS IS'));*/
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: FilterBottomSheetWidget(itemList: filterWatch.yesNoSelectionList.map((e) => e).toList(), title: 'Picked Category', onTapItem: (item) {}),
                  isDismissible: true);
            }, StringConstants.pickCategory)
                .addVisibility((widget.args.fromExploreExpert ?? false)),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.topicController, context, () {
              List<Topic> topicList = [];
              topicList.addAll(widget.args.list ?? []);
              topicList.insert(0, Topic(name: 'SELECT ONE OR LEAVE AS IS'));
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: FilterBottomSheetWidget(itemList: topicList.map((e) => e.name).toList(), title: 'Picked Topic', onTapItem: (item) {}),
                  isDismissible: true);
            }, StringConstants.pickTopicFromTheAbove),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.instantCallAvailabilityController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: FilterBottomSheetWidget(
                      itemList: filterWatch.yesNoSelectionList.map((e) => e).toList(),
                      title: 'Select Call Availability',
                      onTapItem: (item) {
                        filterRead.setValueOfCall(item);
                        context.toPop();
                      }),
                  isDismissible: true);
            }, StringConstants.instantCallsAvailability),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.ratingController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: FilterBottomSheetWidget(
                      itemList: filterWatch.ratingList.map((e) => e).toList(),
                      title: 'Picked Rating',
                      onTapItem: (item) {
                        filterRead.setRating(item);
                        context.toPop();
                      }),
                  isDismissible: true);
            }, StringConstants.overAllRatingText),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.genderController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: FilterBottomSheetWidget(
                    itemList: filterWatch.genderList.map((e) => e.title).toList(),
                    title: 'Picked Gender',
                    onTapItem: (item) {
                      filterRead.setGender(item);
                      context.toPop();
                    },
                  ),
                  isDismissible: true);
            }, StringConstants.genderText),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.countryNameController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: CountryListBottomView(
                    onTapItem: (item) {
                      filterRead.setSelectedCountry(value: item);
                      context.toPop();
                    },
                    clearSearchTap: () => filterRead.clearSearchCountryController(),
                    searchController: filterWatch.searchCountryController,
                  ),
                  isDismissible: true);
            }, StringConstants.countryText),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.cityNameController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  isDismissible: true,
                  child: CityListBottomView(
                    onTapItem: (item) {
                      filterRead.setCity(value: item);
                      context.toPop();
                    },
                    clearSearchTap: () => filterRead.clearSearchCityController(),
                    searchController: filterWatch.searchCityController,
                    countryId: filterWatch.selectedCountryModel?.id ?? '',
                  ));
            }, StringConstants.cityText),
            30.0.spaceY,
            BodySmallText(
              title: StringConstants.feeRange,
              titleColor: ColorConstants.bottomTextColor,
            ),
            RangeSlider(
              values: RangeValues(filterWatch.start, filterWatch.end),
              activeColor: ColorConstants.yellowButtonColor,
              inactiveColor: ColorConstants.lineColor,
              divisions: 25,
              onChanged: filterRead.setRange,
              min: 0,
              max: 100,
            ),
          ],
        ).addPaddingX(20),
      ),
      bottomNavigationBar: PrimaryButton(
        title: StringConstants.applyFilter,
        height: 55,
        onPressed: () {},
      ).addPaddingXY(paddingX: 50, paddingY: 10),
    );
  }

  TextFormFieldWidget buildTextFormFieldWidget(
    TextEditingController controller,
    BuildContext context,
    VoidCallback OnTap,
    String labelText,
  ) {
    return TextFormFieldWidget(
      isReadOnly: true,
      hintText: StringConstants.selectOnrOrLeave,
      controller: controller,
      labelText: labelText,
      labelColor: ColorConstants.bottomTextColor,
      enabledBorderColor: ColorConstants.dropDownBorderColor,
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: FontWeightEnum.w400.toInter, overflow: TextOverflow.ellipsis),
      suffixIcon: Icon(
        size: 18,
        Icons.keyboard_arrow_down_rounded,
        color: ColorConstants.dropDownBorderColor,
      ),
      hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, overflow: TextOverflow.ellipsis),
      onTap: OnTap,
    );
  }
}
