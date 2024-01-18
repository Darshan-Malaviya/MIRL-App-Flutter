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
      //ref.read(cityCountryProvider).AreaCategoryListApiCall();
      ref.read(cityCountryProvider).displayCountry();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    final cityCountryWatch = ref.read(cityCountryProvider);
    final cityCountryRead = ref.read(cityCountryProvider);
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
              expertRead.updateFeesApi();
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
                controller: expertWatch.countryNameController,
                onTap: () {
                  CommonBottomSheet.bottomSheet(context: context, child: CountryListBottomView());
                },
              ),
              20.0.spaceY,
              TitleSmallText(
                title: StringConstants.filterExperts,
                titleTextAlign: TextAlign.center,
                maxLine: 3,
              ),
              20.0.spaceY,
              TextFormFieldWidget(
                isReadOnly: true,
                hintText: StringConstants.nearestLandmark,
                onTap: () {
                  CommonBottomSheet.bottomSheet(context: context, child: CityListBottomView());
                },
              ),
            ],
          ).addAllPadding(20),
        ),
      ),
    );
  }
}
