import 'package:flutter/material.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

class DropDownWidget extends StatefulWidget {
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue = 'HIGHEST REVIEW SCORE';

  var items = ['HIGHEST REVIEW SCORE', 'LOWEST REVIEW SCORE', 'NEWEST REVIEWS', 'OLDEST REVIEWS'];

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
                title: StringConstants.sortReviews,
                fontSize: 10,
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
                    value: dropdownValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 20,
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: LabelSmallText(
                          title: items,
                          fontSize: 10,
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
