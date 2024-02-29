import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/dropdown_widget/dropdown_widget.dart';
import 'package:mirl/ui/screens/edit_profile/widget/city_list_bottom_view.dart';
import 'package:mirl/ui/screens/edit_profile/widget/coutry_list_bottom_view.dart';

class SetYourLocationScreen extends ConsumerStatefulWidget {
  const SetYourLocationScreen({super.key});

  @override
  ConsumerState<SetYourLocationScreen> createState() => _SetYourLocationScreenState();
}

class _SetYourLocationScreenState extends ConsumerState<SetYourLocationScreen> {
  final _loginPassKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    return Scaffold(
      appBar: AppBarWidget(
          leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () => context.toPop(),
          ),
          trailingIcon: InkWell(
            onTap: () {
              if (_loginPassKey.currentState?.validate() ?? false) {
                expertRead.updateYourLocationApi();
              }
            },
            child: TitleMediumText(
              title: StringConstants.done,
              fontFamily: FontWeightEnum.w700.toInter,
            ).addPaddingRight(14),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _loginPassKey,
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
                  controller: expertWatch.locationController,
                  dropdownList: expertWatch.locations.map((String item) => dropdownMenuEntry(context: context, value: item, label: item)).toList(),
                  onSelect: (String value) {
                    expertWatch.locationSelect(value);
                  },
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.specificCityOrCountry,
                  titleTextAlign: TextAlign.center,
                  maxLine: 4,
                ),
                40.0.spaceY,
                TextFormFieldWidget(
                  isReadOnly: true,
                  hintText: LocaleKeys.selectCountry.tr().toUpperCase(),
                  controller: expertWatch.countryNameController,
                  contentPadding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  enabledBorderColor: ColorConstants.dropDownBorderColor,
                  onTap: () {
                    CommonBottomSheet.bottomSheet(
                        context: context,
                        child: CountryListBottomView(
                          onTapItem: (item) {
                            expertRead.setSelectedCountry(value: item);
                            Navigator.pop(context);
                          },
                          clearSearchTap: () => expertRead.clearSearchCountryController(),
                          searchController: expertWatch.searchCountryController,
                        ),
                        isDismissible: true);
                  },
                  validator: (value) {
                    return value?.toEmptyStringValidation(msg: LocaleKeys.pleaseSelectCountry.tr());
                  },
                ),
                20.0.spaceY,
                TitleSmallText(
                  fontFamily: FontWeightEnum.w400.toInter,
                  title: StringConstants.filterExperts,
                  titleTextAlign: TextAlign.center,
                  maxLine: 3,
                ),
                20.0.spaceY,
                TextFormFieldWidget(
                  isReadOnly: true,
                  hintText: LocaleKeys.selectCity.tr().toUpperCase(),
                  controller: expertWatch.cityNameController,
                  contentPadding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  enabledBorderColor: ColorConstants.dropDownBorderColor,
                  onTap: () {
                    CommonBottomSheet.bottomSheet(
                        context: context,
                        isDismissible: true,
                        child: CityListBottomView(
                          onTapItem: (item) {
                            expertRead.displayCity(value: item);
                            Navigator.pop(context);
                          },
                          clearSearchTap: () => expertRead.clearSearchCityController(),
                          searchController: expertWatch.searchCityController,
                          countryName: expertWatch.countryNameController.text,
                        ));
                  },
                  validator: (value) {
                    return value?.toEmptyStringValidation(msg: LocaleKeys.pleaseSelectCity.tr());
                  },
                ),
              ],
            ).addAllPadding(20),
          ),
        ),
      ),
    );
  }
}
