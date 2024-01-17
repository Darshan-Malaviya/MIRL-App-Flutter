import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/color_constants.dart';
import 'package:mirl/infrastructure/commons/constants/image_constants.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/common/text_widgets/textfield/textformfield_widget.dart';
import 'package:mirl/ui/widget/expandble.dart';

class SetYourLocationScreen extends ConsumerStatefulWidget {
  const SetYourLocationScreen({super.key});

  @override
  ConsumerState<SetYourLocationScreen> createState() => _SetYourLocationScreenState();
}

class _SetYourLocationScreenState extends ConsumerState<SetYourLocationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(cityCountryProvider).AreaCategoryListApiCall();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    final cityCountryWatch = ref.read(cityCountryProvider);
    return Scaffold(
      appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          trailingIcon: InkWell(
            onTap: () {
              expertRead.UpdateUserDetailsApiCall();
            },
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TitleLargeText(
                title: StringConstants.setYourLocation,
                titleColor: ColorConstants.bottomTextColor,
                fontFamily: FontWeightEnum.w700.toInter,
              ),
              20.0.spaceY,
              TitleMediumText(
                title: StringConstants.visibleOnYourProfile,
                titleColor: ColorConstants.blackColor,
                fontFamily: FontWeightEnum.w700.toInter,
                titleTextAlign: TextAlign.center,
                fontSize: 15,
              ),
              20.0.spaceY,

              DropdownMenuWidget(
                hintText: StringConstants.theDropDown,
                dropdownList: expertWatch.locations
                    .map((String item) => dropdownMenuEntry(context: context, value: item, label: item))
                    .toList(),
                onSelect: (String value) {
                  expertWatch.setYesNo(value);
                },
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.specificCityOrCountry,
                titleTextAlign: TextAlign.center,
                maxLine: 4,
              ),
              40.0.spaceY,
              TextFormFieldWidget(
                isReadOnly: true,
                hintText: StringConstants.nearestLandmark,
                onTap: () {
                 // CommonBottomSheet.bottomSheet(context: context, child: );
                },
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.filterExperts,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              20.0.spaceY,
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: ColorConstants.whiteColor,
                    border: Border.all(color: ColorConstants.borderColor)),
                child: Column(
                  children: [
                    ExpandablePanel(
                        header: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            StringConstants.theDropDown,
                            style: TextStyle(fontSize: 12, color: ColorConstants.blackColor),
                          ),
                        ),
                        collapsed: const SizedBox.shrink(),
                        expanded: SizedBox(
                          height: 130,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                cityCountryWatch.country.length,
                                (index) => SizedBox(
                                  height: 40,
                                  child: ListTile(
                                    title: Text(cityCountryWatch.country[index].country ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: ColorConstants.blackColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        //tapHeaderToExpand: true,
                        //hasIcon: true,
                        ),
                    /* Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),

                            )*/
                  ],
                ),
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
          ).addAllPadding(20),
        ),
      ),
    );
  }
}
