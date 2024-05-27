import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_id_name_common_model.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/dropdown_widget/sort_experts_droup_down_widget.dart';
import 'package:mirl/ui/common/range_slider/range_slider_widget.dart';
import 'package:mirl/ui/common/range_slider/thumb_shape.dart';
import 'package:mirl/ui/screens/edit_profile/widget/city_list_bottom_view.dart';
import 'package:mirl/ui/screens/edit_profile/widget/coutry_list_bottom_view.dart';
import 'package:mirl/ui/screens/filter_screen/widget/filter_bottomsheet_widget.dart';
import 'package:mirl/ui/screens/filter_screen/widget/topic_list_by_category_bottom_view.dart';

class MultiConnectFilterScreen extends ConsumerStatefulWidget {
  const MultiConnectFilterScreen({super.key});

  @override
  ConsumerState createState() => _MultiConnectFilterScreenState();
}

class _MultiConnectFilterScreenState extends ConsumerState<MultiConnectFilterScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterWatch = ref.watch(filterProvider);
    final filterRead = ref.read(filterProvider);
    final multiProviderRead = ref.read(multiConnectProvider);

    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            context.toPop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleLargeText(
              title: LocaleKeys.multiConnectFilter.tr(),
              maxLine: 2,
              titleTextAlign: TextAlign.center,
            ),
            // 20.0.spaceY,
            // buildTextFormFieldWidget(filterWatch.categoryController, context, () {
            //   CommonBottomSheet.bottomSheet(context: context, isDismissible: true, child: AllCategoryListBottomView());
            // }, StringConstants.pickCategory),
            30.0.spaceY,
            buildTextFormFieldWidget(filterWatch.topicController, context, () {
              //if (filterWatch.categoryController.text.isNotEmpty) {
                CommonBottomSheet.bottomSheet(
                    context: context,
                    isDismissible: true,
                    child: TopicListByCategoryBottomView(
                      isFromExploreExpert: true,
                      category: filterWatch.selectedCategory ?? CategoryIdNameCommonModel(),
                    ));
              // } else {
              //   FlutterToast().showToast(msg: LocaleKeys.pleaseSelectCategoryFirst.tr());
              // }
            }, StringConstants.pickTopic.toUpperCase(),hintText: StringConstants.pickTopic.toUpperCase()),
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
              data: SliderTheme.of(context)
                  .copyWith(rangeThumbShape: RoundRangeSliderThumbShapeWidget(thumbColor: ColorConstants.bottomTextColor)),
              child: RangeSliderWidget(
                values: RangeValues(filterRead.start ?? 0, filterWatch.end ?? 0),
                activeColor: ColorConstants.yellowButtonColor,
                inactiveColor: ColorConstants.lineColor,
                divisions: 4,
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
                  title: 'PRO\nBONO',
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

              filterRead.clearSingleCategoryData();

              filterRead.setSelectedFilterForMultiConnect();

              await multiProviderRead.getSingleCategoryApiCall(
                  categoryId: filterWatch.selectedCategory?.id.toString() ?? '',
                  context: context,
                  isFromFilter: true,
                  requestModel: ExpertDataRequestModel(
                    multiConnectRequest: 'true',
                    categoryId: (filterWatch.selectedCategory?.id.toString().isNotEmpty ?? false)
                        ? filterWatch.selectedCategory?.id.toString()
                        : null,
                    topicIds: selectedTopicId,
                    userId: SharedPrefHelper.getUserId,
                    city: filterWatch.cityNameController.text.isNotEmpty ? filterWatch.cityNameController.text : null,
                    country: filterWatch.countryNameController.text.isNotEmpty ? filterWatch.countryNameController.text : null,
                    gender: filterWatch.genderController.text.isNotEmpty ? (filterWatch.selectGender ?? 0).toString() : null,
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
                  ));
            } else {
              FlutterToast().showToast(msg: LocaleKeys.pleasePickAnyFilter.tr());
            }
          }).addPaddingXY(paddingX: 50, paddingY: 18),
    );
  }

  TextFormFieldWidget buildTextFormFieldWidget(
    TextEditingController controller,
    BuildContext context,
    VoidCallback OnTap,
    String labelText,
      {String? hintText}
  ) {
    return TextFormFieldWidget(
      isReadOnly: true,
      hintText: hintText ??StringConstants.selectOnrOrLeave,
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
