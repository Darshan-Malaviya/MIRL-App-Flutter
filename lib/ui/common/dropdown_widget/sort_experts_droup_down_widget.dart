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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LabelSmallText(
                title: StringConstants.sortExpert,
                fontSize: 8,
                fontFamily: FontWeightEnum.w400.toInter,
              ),
              Container(
                height: 30,
                padding: EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: ColorConstants.dropDownBorderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
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
                          title: items,
                          fontSize: 8,
                          fontFamily: FontWeightEnum.w400.toInter,
                        ),
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
              Container(
                height: 30,
                padding: EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: ColorConstants.dropDownBorderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
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
                          title: item,
                          fontSize: 8,
                          fontFamily: FontWeightEnum.w400.toInter,
                        ),
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
