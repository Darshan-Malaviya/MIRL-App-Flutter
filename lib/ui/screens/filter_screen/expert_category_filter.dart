import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/visibiliity_extension.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/ui/common/range_slider/range_slider_widget.dart';
import 'package:mirl/ui/common/range_slider/thumb_shape.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/dropdown_widget/sort_experts_droup_down_widget.dart';
import 'package:mirl/ui/screens/edit_profile/widget/city_list_bottom_view.dart';
import 'package:mirl/ui/screens/edit_profile/widget/coutry_list_bottom_view.dart';
import 'package:mirl/ui/screens/filter_screen/widget/all_category_list_bottom_view.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
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
      if (widget.args.fromExploreExpert ?? false) {
        ref.read(filterProvider).setOtherCategoryValueFalse();
      } else {
        ref.read(filterProvider).getSelectedCategory();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterWatch = ref.watch(filterProvider);
    final filterRead = ref.read(filterProvider);

    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            filterRead.clearAllFilter();
            context.toPop();
          },
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
            if (filterWatch.selectedCategory != null) ...[
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
                    title: filterWatch.selectedCategory?.name ?? '',
                  ),
                ],
              ).addVisibility(!(widget.args.fromExploreExpert ?? false)),
            ],
            widget.args.fromExploreExpert ?? false ? 20.0.spaceY : 0.0.spaceY,
            buildTextFormFieldWidget(filterWatch.categoryController, context, () {
              CommonBottomSheet.bottomSheet(context: context, isDismissible: true, child: AllCategoryListBottomView());
            }, StringConstants.pickCategory)
                .addVisibility(widget.args.fromExploreExpert ?? false),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.topicController, context, () {
              if (filterWatch.categoryController.text.isNotEmpty) {
                CommonBottomSheet.bottomSheet(
                    context: context,
                    isDismissible: true,
                    child: TopicListByCategoryBottomView(
                      isFromExploreExpert: widget.args.fromExploreExpert ?? false,
                      category: filterWatch.selectedCategory ?? CategoryIdNameCommonModel(),
                    ));
              } else {
                FlutterToast().showToast(msg: LocaleKeys.pleaseSelectCategoryFirst.tr());
              }
            }, StringConstants.pickTopicFromTheAbove, hintText: LocaleKeys.pickCategoryTopic.tr()),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.instantCallAvailabilityController, context, () {
              CommonBottomSheet.bottomSheet(
                  context: context,
                  child: FilterBottomSheetWidget(
                      itemList: filterWatch.callSelectionList.map((e) => e).toList(),
                      title: LocaleKeys.selectCallAvailability.tr().toUpperCase(),
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
                      itemList: filterWatch.ratingList.map((e) => e.title).toList(),
                      title: LocaleKeys.pickRating.tr().toUpperCase(),
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
                    title: LocaleKeys.pickGender.tr().toUpperCase(),
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
              if (filterWatch.countryNameController.text.isEmpty) {
                FlutterToast().showToast(msg: LocaleKeys.pleaseSelectCountryFirst.tr());
                return;
              }
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
                    countryName: filterWatch.selectedCountryModel?.country ?? '',
                  ));
            }, StringConstants.cityText),
            30.0.spaceY,
            SortExpertDropDown(),
            30.0.spaceY,
            BodySmallText(
              title: StringConstants.feeRange,
              titleColor: ColorConstants.bottomTextColor,
            ),
            10.0.spaceY,
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                rangeThumbShape: RoundRangeSliderThumbShapeWidget(thumbColor: ColorConstants.bottomTextColor),
                showValueIndicator: ShowValueIndicator.onlyForContinuous,
              ),
              child: RangeSliderWidget(
                values: RangeValues(filterRead.start ?? 0, filterWatch.end ?? 0),
                activeColor: ColorConstants.yellowButtonColor,
                inactiveColor: ColorConstants.lineColor,
                divisions: 100,
                onChanged: filterRead.setRange,
                min: 0,
                max: 100,
              ),
            ),
            10.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelSmallText(
                  title: LocaleKeys.proBono.tr(),
                  fontFamily: FontWeightEnum.w400.toInter,
                ).addMarginLeft(10),
                LabelSmallText(
                  title: '\$100+',
                  fontFamily: FontWeightEnum.w400.toInter,
                ),
              ],
            ),
            if (filterWatch.start != null && filterWatch.end != null) ...[
              BodySmallText(
                title: filterWatch.end == 100
                    ? '\$${filterWatch.start?.toStringAsFixed(2)} - \$${filterWatch.end?.toStringAsFixed(2)}+'
                    : '\$${filterWatch.start?.toStringAsFixed(2)} - \$${filterWatch.end?.toStringAsFixed(2)}',
                titleColor: ColorConstants.bottomTextColor,
              ),
              50.0.spaceY,
            ]
          ],
        ).addPaddingX(20),
      ),
      bottomNavigationBar: PrimaryButton(
        title: StringConstants.applyFilter,
        height: 55,
        onPressed: () async {
          if (filterWatch.commonSelectionModel.isNotEmpty) {
            String? selectedTopicId;
            if (filterWatch.selectedTopicList?.isNotEmpty ?? false) {
              if (filterWatch.selectedTopicList?.any((element) => (element.id == 0)) ?? false) {
                selectedTopicId = null;
              } else {
                selectedTopicId = filterWatch.selectedTopicList?.map((e) => e.id).join(",");
              }
            }
            double endFeeRange = filterWatch.end ?? 0;
            double startFeeRange = filterWatch.start ?? 0;
            if (widget.args.fromExploreExpert ?? false) {
              filterRead.clearExploreExpertSearchData();
              filterRead.clearExploreController();
              await filterRead.exploreExpertUserAndCategoryApiCall(
                  context: context,
                  isFromFilter: true,
                  requestModel: ExpertDataRequestModel(
                      userId: SharedPrefHelper.getUserId,
                      categoryId: (filterWatch.selectedCategory?.id.toString().isNotEmpty ?? false)
                          ? filterWatch.selectedCategory?.id.toString()
                          : null,
                      city: filterWatch.cityNameController.text.isNotEmpty ? filterWatch.cityNameController.text : null,
                      country: filterWatch.countryNameController.text.isNotEmpty ? filterWatch.countryNameController.text : null,
                      gender: filterWatch.genderController.text.isNotEmpty ? (filterWatch.selectGender ?? 0).toString() : null,
                      instantCallAvailable: filterWatch.instantCallAvailabilityController.text.isNotEmpty
                          ? filterWatch.isCallSelect == 1
                              ? "true"
                              : "false"
                          : null,
                      /*  experienceOder: "ASC",
                  reviewOrder: "ASC",*/
                      maxFee: filterWatch.end != null ? (endFeeRange * 100).toInt().toString() : null,
                      minFee: filterWatch.start != null ? (startFeeRange * 100).toInt().toString() : null,
                      feeOrder: filterWatch.sortBySelectedItem == 'SORT BY'
                          ? null
                          : filterWatch.sortBySelectedItem == 'PRICE'
                              ? filterWatch.sortBySelectedOrder == 'HIGH TO LOW'
                                  ? 'DESC'
                                  : 'ASC'
                              : null,
                      overAllRating: filterWatch.selectedRating != null ? filterWatch.selectedRating.toString() : null,
                      ratingOrder: filterWatch.sortBySelectedItem == 'SORT BY'
                          ? null
                          : filterWatch.sortBySelectedItem == 'REVIEW SCORE'
                              ? filterWatch.sortBySelectedOrder == 'HIGH TO LOW'
                                  ? 'DESC'
                                  : 'ASC'
                              : null,
                      topicIds: selectedTopicId));
            } else {
              filterRead.clearSingleCategoryData();
              await filterRead.getSingleCategoryApiCall(
                  categoryId: filterWatch.selectedCategory?.id.toString() ?? '',
                  context: context,
                  isFromFilter: true,
                  requestModel: ExpertDataRequestModel(
                      city: filterWatch.cityNameController.text.isNotEmpty ? filterWatch.cityNameController.text : null,
                      country: filterWatch.countryNameController.text.isNotEmpty ? filterWatch.countryNameController.text : null,
                      /*  experienceOder: "ASC",
                    feeOrder: "ASC",
                    reviewOrder: "ASC",*/
                      gender: filterWatch.genderController.text.isNotEmpty ? (filterWatch.selectGender ?? 0).toString() : null,
                      instantCallAvailable: filterWatch.instantCallAvailabilityController.text.isNotEmpty
                          ? filterWatch.isCallSelect == 1
                              ? "true"
                              : "false"
                          : null,
                      maxFee: filterWatch.end != null ? (endFeeRange * 100.0).toString() : null,
                      minFee: filterWatch.start != null ? (startFeeRange * 100.0).toString() : null,
                      feeOrder: filterWatch.sortBySelectedItem == 'SORT BY'
                          ? null
                          : filterWatch.sortBySelectedItem == 'PRICE'
                              ? filterWatch.sortBySelectedOrder == 'HIGH TO LOW'
                                  ? 'DESC'
                                  : 'ASC'
                              : null,
                      overAllRating: filterWatch.selectedRating != null ? filterWatch.selectedRating.toString() : null,
                      ratingOrder: filterWatch.sortBySelectedItem == 'SORT BY'
                          ? null
                          : filterWatch.sortBySelectedItem == 'REVIEW SCORE'
                              ? filterWatch.sortBySelectedOrder == 'HIGH TO LOW'
                                  ? 'DESC'
                                  : 'ASC'
                              : null,
                      topicIds: selectedTopicId,
                      userId: SharedPrefHelper.getUserId));
            }
          } else {
            FlutterToast().showToast(msg: LocaleKeys.pleasePickAnyFilter.tr());
          }
        },
      ).addPaddingXY(paddingX: 50, paddingY: 18),
    );
  }

  TextFormFieldWidget buildTextFormFieldWidget(
      TextEditingController controller, BuildContext context, VoidCallback OnTap, String labelText,
      {String? hintText}) {
    return TextFormFieldWidget(
      isReadOnly: true,
      hintText: hintText ?? StringConstants.selectOnrOrLeave,
      controller: controller,
      labelText: labelText,
      labelColor: ColorConstants.bottomTextColor,
      enabledBorderColor: ColorConstants.dropDownBorderColor,
      labelTextFontFamily: FontWeightEnum.w700.toInter,
      textStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: FontWeightEnum.w400.toInter, overflow: TextOverflow.ellipsis),
      suffixIcon: Icon(
        size: 18,
        Icons.keyboard_arrow_down_rounded,
        color: ColorConstants.dropDownBorderColor,
      ),
      hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ColorConstants.buttonTextColor, fontFamily: FontWeightEnum.w400.toInter, overflow: TextOverflow.ellipsis),
      onTap: OnTap,
    );
  }
}
