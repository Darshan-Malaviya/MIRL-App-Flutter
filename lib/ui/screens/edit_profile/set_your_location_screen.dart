import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/common/text_widgets/textfield/textformfield_widget.dart';

class SetYourLocationScreen extends ConsumerStatefulWidget {
  const SetYourLocationScreen({super.key});

  @override
  ConsumerState<SetYourLocationScreen> createState() => _SetYourLocationScreenState();
}

class _SetYourLocationScreenState extends ConsumerState<SetYourLocationScreen> {
  List<String> _locations = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        trailingIcon: TitleMediumText(
          title: StringConstants.done,
          fontFamily: FontWeightEnum.w700.toInter,
        ).addPaddingRight(14),
        appTitle: TitleLargeText(
          title: StringConstants.setYourLocation,
          titleColor: ColorConstants.bottomTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TitleMediumText(
                title: StringConstants.visibleOnYourProfile,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w700.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ).addAllPadding(14),
              DropdownMenuWidget(
                hintText: StringConstants.theDropDown,
                dropdownList: _locations
                    .map((String item) => dropdownMenuEntry(context: context, value: StringConstants.theDropDown, label: item))
                    .toList(),
                onSelect: (String value) {},
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.specificCityOrCountry,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              40.0.spaceY,
              TextFormFieldWidget(
                fontFamily: FontWeightEnum.w400.toInter,
                hintText: StringConstants.nearestLandmark,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ).addPaddingX(24),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.filterExperts,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w400.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              // DropdownButtonFormField(
              //   icon: Icon(Icons.keyboard_arrow_down_sharp),
              //   decoration: InputDecoration(
              //     enabledBorder: OutlineInputBorder(
              //       //<-- SEE HERE
              //       borderSide: BorderSide(color: ColorConstants.dropDownBorderColor, width: 1),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       //<-- SEE HERE
              //       borderSide: BorderSide(color: Colors.black, width: 1),
              //     ),
              //     filled: true,
              //     fillColor: Colors.white,
              //   ),
              //   dropdownColor: Colors.white,
              //   value: dropdownValue,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       dropdownValue = newValue!;
              //     });
              //   },
              //   items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(
              //         value,
              //         style: TextStyle(fontSize: 20),
              //       ),
              //     );
              //   }).toList(),
              // ).addPaddingX(44)

              // DropdownButton<String>(
              //   value: chosenValue,
              //   items: <String>[
              //     'Yes',
              //     'No',
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   hint: Text(
              //     "SELECT YES OR NO FROM THE DROPDOWN ",
              //     style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
              //   ),
              //   // onChanged: (){},
              //   onChanged: (value) {
              //     setState(() {
              //       chosenValue = value;
              //     });
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
