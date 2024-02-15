import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              expertRead.updateYourLocationApi();
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
                hintText: StringConstants.nearestLandmark,
                controller: expertWatch.countryNameController,
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
                hintText: StringConstants.nearestLandmark,
                controller: expertWatch.cityNameController,
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
                        countryId: expertWatch.selectedCountryModel?.id ?? '',
                      ));
                },
              ),
            ],
          ).addAllPadding(20),
        ),
      ),
    );
  }
}
