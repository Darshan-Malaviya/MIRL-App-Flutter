import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SortExpertDropDown extends ConsumerStatefulWidget {
  @override
  _SortExpertDropDownState createState() => _SortExpertDropDownState();
}

class _SortExpertDropDownState extends ConsumerState<SortExpertDropDown> {
  @override
  Widget build(BuildContext context) {
    final filterProviderWatch = ref.watch(filterProvider);
    final filterProviderRead = ref.read(filterProvider);

    return Column(
      children: [
        BodySmallText(
          title: LocaleKeys.shortByExpert.tr(),
          fontFamily: FontWeightEnum.w700.toInter,
          titleColor: ColorConstants.bottomTextColor,
        ),
        6.0.spaceY,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                height: 45,
                padding: EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shadows: [
                    BoxShadow(
                      color: ColorConstants.dropDownBorderColor.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0,
                      offset: Offset(
                        1, // horizontal, move right 10
                        1,
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorConstants.dropDownBorderColor),
                    borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    elevation: 0,
                    value: filterProviderWatch.sortBySelectedItem,
                    padding: EdgeInsets.zero,
                    enableFeedback: true,
                    icon: Icon(
                      size: 18,
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorConstants.dropDownBorderColor,
                    ),
                    items: filterProviderWatch.sortByItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: LabelSmallText(
                          maxLine: 2,
                          title: items,
                          fontSize: 8,
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.buttonTextColor,
                        ).addMarginX(6),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      filterProviderRead.setSortByPriceValue(sortByValue: newValue ?? '', order: filterProviderWatch.sortBySelectedOrder);
                    },
                  ),
                ),
              ),
            ),
            20.0.spaceX,
            Flexible(
              child: Container(
                height: 45,
                padding: EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shadows: [
                    BoxShadow(
                      color: ColorConstants.dropDownBorderColor.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0,
                      offset: Offset(
                        1, // horizontal, move right 10
                        1,
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorConstants.dropDownBorderColor),
                    borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    elevation: 0,
                    value: filterProviderWatch.sortBySelectedOrder,
                    padding: EdgeInsets.zero,
                    focusNode: FocusNode(),
                    enableFeedback: true,
                    icon: Icon(
                      size: 18,
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorConstants.dropDownBorderColor,
                    ),
                    items: filterProviderWatch.orderFilterList.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: LabelSmallText(
                          maxLine: 2,
                          title: item,
                          fontSize: 8,
                          fontFamily: FontWeightEnum.w400.toInter,
                          titleColor: ColorConstants.buttonTextColor,
                        ).addMarginX(6),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      filterProviderRead.setSortByPriceValue(sortByValue: filterProviderWatch.sortBySelectedItem, order: newValue ?? '');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
