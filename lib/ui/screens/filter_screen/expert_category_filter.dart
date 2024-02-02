import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/ui/screens/edit_profile/widget/city_list_bottom_view.dart';
import 'package:mirl/ui/screens/edit_profile/widget/coutry_list_bottom_view.dart';
import 'package:mirl/ui/screens/filter_screen/widget/all_category_list_bottom_view.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_args.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_bottomsheet_widget.dart';
import 'package:mirl/ui/screens/filter_screen/widget/topic_list_by_category_bottom_view.dart';

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
            /// TODO This is selected filter list
            Column(
              children: List.generate(filterWatch.commonSelectionModel.length, (index) {
                final data = filterWatch.commonSelectionModel[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OnScaleTap(
                      onPress: () {},
                      child: ShadowContainer(
                        border: 20,
                        height: 30,
                        width: 30,
                        shadowColor: ColorConstants.borderColor,
                        backgroundColor: ColorConstants.yellowButtonColor,
                        offset: Offset(0, 3),
                        child: Center(child: Image.asset(ImageConstants.cancel)),
                      ),
                    ),
                    20.0.spaceX,
                    ShadowContainer(
                      border: 10,
                      child: BodyMediumText(
                        title: '${data.title}: ${data.value}',
                        fontFamily: FontWeightEnum.w400.toInter,
                      ),
                    )
                  ],
                ).addPaddingY(10);
              }),
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
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.categoryController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  isDismissible: true,
                  child: AllCategoryListBottomView(
                    onTapItem: (item) {
                      filterWatch.setCategory(value: item);
                      Navigator.pop(context);
                    },
                    clearSearchTap: () => {filterRead.clearSearchCategoryController()},
                    searchController: filterWatch.categoryController,
                  ));
            }, StringConstants.pickCategory).addVisibility(widget.args.fromExploreExpert ?? false),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.topicController, context, () {
              if(filterWatch.selectedCategory != null){
                CommonBottomSheet.bottomSheet(
                    context: context,
                    isDismissible: true,
                    child: TopicListByCategoryBottomView(
                      onTapItem: (item) {
                        filterWatch.setTopicByCategory(value: [item]);
                        Navigator.pop(context);
                      },
                      clearSearchTap: () => {filterRead.clearSearchTopicController()},
                      searchController: filterWatch.topicController,
                      categoryId: filterWatch.selectedCategory?.id.toString() ?? '',
                    ));
              } else {
                FlutterToast().showToast(msg: "Please select category first");
              }

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
