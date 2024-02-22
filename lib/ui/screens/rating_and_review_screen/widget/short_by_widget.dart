import 'package:easy_localization/easy_localization.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ShortByReview extends StatelessWidget {
  final String? value;
  final List<String> itemList;
  final Function(String?)? onChanged;

  const ShortByReview({super.key, required this.value, required this.itemList, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BodySmallText(
          title: LocaleKeys.shortByReview.tr(),
          fontFamily: FontWeightEnum.w400.toInter,
          titleColor: ColorConstants.buttonTextColor,
        ),
        30.0.spaceX,
        Expanded(
          child: Container(
            height: 40,
            width: 60,
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
            child: Theme(
              data: ThemeData(
                canvasColor: ColorConstants.ratingColor,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  elevation: 0,
                  value: value,
                  padding: EdgeInsets.zero,
                  enableFeedback: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 20,
                  ),
                  items: itemList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: LabelSmallText(
                        maxLine: 2,
                        title: items,
                        fontSize: 10,
                        fontFamily: FontWeightEnum.w400.toInter,
                        titleColor: ColorConstants.buttonTextColor,
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
