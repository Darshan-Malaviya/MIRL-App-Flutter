import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ShortReportWidget extends StatelessWidget {
  final String? value;
  final List<String> itemList;
  final Function(String?)? onChanged;

  const ShortReportWidget({super.key, required this.itemList, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 20),
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
                child: BodySmallText(
                  maxLine: 2,
                  title: items,
                  fontFamily: FontWeightEnum.w400.toInter,
                  titleColor: ColorConstants.buttonTextColor,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
