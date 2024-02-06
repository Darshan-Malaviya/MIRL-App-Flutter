import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class SortExpertDropDown extends StatefulWidget {
  @override
  _SortExpertDropDownState createState() => _SortExpertDropDownState();
}

class _SortExpertDropDownState extends State<SortExpertDropDown> {
  String dropdown = 'PRICE';
  String dropdownValue = 'HIGH TO LOW';

  var items = ['PRICE', 'REVIEW SCORE', 'EXPERIENCE'];
  var item = ['HIGH TO LOW', ' LOW TO HIGH'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelSmallText(
                title: StringConstants.sortExpert,
                fontSize: 8,
                fontFamily: FontWeightEnum.w400.toInter,
                titleColor: ColorConstants.buttonTextColor,
              ),
              16.0.spaceX,
              Container(
                height: 30,
                padding: EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shadows: [
                    BoxShadow(
                      color: ColorConstants.dropDownBorderColor.withOpacity(0.1),
                      blurRadius: 5.0, // has the effect of softening the shadow
                      spreadRadius: 0, // has the effect of extending the shadow
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
                    //isExpanded: true,
                    elevation: 0,
                    value: dropdown,
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 20,
                    ),
                    items: items.map((String items) {
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
                      setState(() {
                        dropdown = newValue!;
                      });
                    },
                  ),
                ),
              ),
              10.0.spaceX,
              Container(
                height: 30,
                padding: EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shadows: [
                    BoxShadow(
                      color: ColorConstants.dropDownBorderColor.withOpacity(0.1),
                      blurRadius: 5.0, // has the effect of softening the shadow
                      spreadRadius: 0, // has the effect of extending the shadow
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
                    // isExpanded: true,
                    elevation: 0,
                    value: dropdownValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 20,
                    ),
                    items: item.map((String item) {
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
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
