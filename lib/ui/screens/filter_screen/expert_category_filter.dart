import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/ui/common/range_slider/thumb_shape.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/dropdown_widget/sort_experts_droup_down_widget.dart';
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
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     if(widget.args.fromExploreExpert ?? false) {
       ref.read(filterProvider).setOtherCategoryValueFalse();
     } else {
       ref.read(filterProvider).getSelectedCategory();
     }
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final commonProviderWatch = ref.watch(commonAppProvider);
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
            if(filterWatch.selectedCategory != null)...[
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
                    title:filterWatch.selectedCategory?.name ?? '',
                  ),
                  30.0.spaceY,
                ],
              ).addVisibility(!(widget.args.fromExploreExpert ?? false)),
            ],
            buildTextFormFieldWidget(filterWatch.categoryController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  isDismissible: true,
                  child: AllCategoryListBottomView());
            }, StringConstants.pickCategory).addVisibility(widget.args.fromExploreExpert ?? false),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.topicController, context, () {
              if(filterWatch.categoryController.text.isNotEmpty){
                CommonBottomSheet.bottomSheet(
                    context: context,
                    isDismissible: false,
                    child: TopicListByCategoryBottomView(
                      isFromExploreExpert: widget.args.fromExploreExpert ?? false,
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
                      title: 'Select Call Availability'.toUpperCase(),
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
                      title: 'Pick a Rating'.toUpperCase(),
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
                    title: 'Pick a Gender'.toUpperCase(),
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
            SortExpertDropDown(),
            30.0.spaceY,
            BodySmallText(
              title: StringConstants.feeRange,
              titleColor: ColorConstants.bottomTextColor,
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(rangeThumbShape:  RoundRangeSliderThumbShapeWidget(thumbColor: ColorConstants.bottomTextColor)),
              child: RangeSlider(
                values: RangeValues(filterWatch.start, filterWatch.end),
                activeColor: ColorConstants.yellowButtonColor,
                inactiveColor: ColorConstants.lineColor,
                divisions: 25,
                onChanged: filterRead.setRange,
                min: 0,
                max: 100,
              ),
            ),
            10.0.spaceY,
            BodySmallText(
              title: '${filterWatch.start - filterWatch.end}',
              titleColor: ColorConstants.bottomTextColor,
            ),
          ],
        ).addPaddingX(20),
      ),
      bottomNavigationBar: PrimaryButton(
        title: StringConstants.applyFilter,
        height: 55,
        onPressed: () async {
          if(widget.args.fromExploreExpert ?? false){
            String? selectedTopicId;
            if(filterWatch.selectedTopicList?.isNotEmpty ?? false){
              selectedTopicId = filterWatch.selectedTopicList?.map((e) => e.id).join(",");
            }
            await filterRead.exploreExpertUserAndCategoryApiCall(
                context: context,
                isFromFilter: true,
                requestModel: ExpertDataRequestModel(
                    userId: SharedPrefHelper.getUserId,
                    categoryId: (filterWatch.selectedCategory?.id.toString().isNotEmpty ?? false) ? filterWatch.selectedCategory?.id.toString() : null,
                    city: filterWatch.cityNameController.text.isNotEmpty ? filterWatch.cityNameController.text : null,
                    country:filterWatch.countryNameController.text.isNotEmpty ? filterWatch.countryNameController.text : null,
                    gender: filterWatch.genderController.text.isNotEmpty ? ((filterWatch.selectGender ?? 0 ) - 1 ).toString()  : null,
                    instantCallAvailable: filterWatch.instantCallAvailabilityController.text.isNotEmpty ? filterWatch.isCallSelect == 1 ? "true" : "false" : null,
                    /*  experienceOder: "ASC",
                    feeOrder: "ASC",
                    reviewOrder: "ASC",
                      maxFee: "10",
                    minFee: "10",*/
                    limit: "10",
                    page: "1",
                    topicIds: selectedTopicId)
            );

          } else {
            String? selectedTopicId;
            if(filterWatch.selectedTopicList?.isNotEmpty ?? false){
              selectedTopicId = filterWatch.selectedTopicList?.map((e) => e.id).join(",");
            }
            await filterRead.getSingleCategoryApiCall(categoryId: filterWatch.selectedCategory?.id.toString() ?? '',
                context: context,
                isFromFilter: true,
                requestModel: ExpertDataRequestModel(
                    city: filterWatch.cityNameController.text.isNotEmpty ? filterWatch.cityNameController.text : null,
                    country:filterWatch.countryNameController.text.isNotEmpty ? filterWatch.countryNameController.text : null,
                  /*  experienceOder: "ASC",
                    feeOrder: "ASC",
                    reviewOrder: "ASC",*/
                    gender: filterWatch.genderController.text.isNotEmpty ? ((filterWatch.selectGender ?? 0 ) - 1 ).toString()  : null,
                    instantCallAvailable: filterWatch.instantCallAvailabilityController.text.isNotEmpty ? filterWatch.isCallSelect == 1 ? "true" : "false" : null,
                    limit: "10",
                  /*  maxFee: "10",
                    minFee: "10",*/
                    page: "1",
                    topicIds: selectedTopicId,
                    userId: SharedPrefHelper.getUserId)
            );
          }
        },
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
      labelTextFontFamily: FontWeightEnum.w700.toInter,
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
