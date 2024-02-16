import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodySmallText(
              title: StringConstants.sortExpert,
              fontFamily: FontWeightEnum.w400.toInter,
              titleColor: ColorConstants.buttonTextColor,
            ),
            8.0.spaceX,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      height: 30,
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
                          side: BorderSide(width: 1.5, color: ColorConstants.dropDownBorderColor),
                          borderRadius: BorderRadius.circular(5),
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
                            Icons.keyboard_arrow_down_sharp,
                            size: 20,
                          ),
                          items: filterProviderWatch.sortByItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: LabelSmallText(
                                maxLine: 2,
                                title: items,
                                fontSize: 8,
                                fontFamily: FontWeightEnum.w400.toInter,
                              ).addMarginX(6),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            /*       setState(() {
                              filterProviderWatch.sortBySelectedItem = newValue!;
                            });*/
                            filterProviderRead.setSortByPriceValue(sortByValue: newValue ?? '', order: filterProviderWatch.sortBySelectedOrder);
                          },
                        ),
                      ),
                    ),
                  ),
                  4.0.spaceX,
                  Flexible(
                    child: Container(
                      height: 30,
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
                          side: BorderSide(width: 1.5, color: ColorConstants.dropDownBorderColor),
                          borderRadius: BorderRadius.circular(5),
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
                            Icons.keyboard_arrow_down_sharp,
                            size: 20,
                          ),
                          items: filterProviderWatch.orderFilterList.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: LabelSmallText(
                                maxLine: 2,
                                title: item,
                                fontSize: 8,
                                fontFamily: FontWeightEnum.w400.toInter,
                              ).addMarginX(6),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            /*       setState(() {
                              filterProviderWatch.sortBySelectedOrder = newValue!;
                            });*/
                            filterProviderRead.setSortByPriceValue(sortByValue: filterProviderWatch.sortBySelectedItem, order: newValue ?? '');
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
