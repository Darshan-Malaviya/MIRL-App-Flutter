import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';

class CityListBottomView extends ConsumerStatefulWidget {
  final Function(CityModel item) onTapItem;
  final TextEditingController searchController;
  final VoidCallback clearSearchTap;
  final String countryName;

  const CityListBottomView(
      {super.key,
      required this.onTapItem,
      required this.searchController,
      required this.clearSearchTap,
      required this.countryName});

  @override
  ConsumerState<CityListBottomView> createState() => _CityListBottomViewState();
}

class _CityListBottomViewState extends ConsumerState<CityListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.clearSearchTap();
      ref.read(commonAppProvider).clearCountryPaginationData();
      ref.read(commonAppProvider).cityListApiCall(isFullScreenLoader: true, countryName: widget.countryName);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(commonAppProvider).reachedCityLastPage;
        if (!isLoading) {
          ref.read(commonAppProvider).cityListApiCall(countryName: widget.countryName);
        } else {
          log('reach last page on city list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commonWatch = ref.watch(commonAppProvider);
    final commonRead = ref.read(commonAppProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TitleMediumText(title: LocaleKeys.selectCity.tr().toUpperCase(), titleColor: ColorConstants.sheetTitleColor),
            16.0.spaceY,
            TextFormFieldWidget(
              isReadOnly: false,
              hintText: LocaleKeys.searchHere.tr(),
              suffixIcon: widget.searchController.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        commonRead.clearCityPaginationData();
                        widget.clearSearchTap();
                        commonRead.cityListApiCall(countryName: widget.countryName);
                      },
                      child: Icon(Icons.close))
                  : SizedBox.shrink(),
              onFieldSubmitted: (value) {
                context.unFocusKeyboard();
                commonRead.clearCityPaginationData();
                commonRead.cityListApiCall(searchName: value.trim(), countryName: widget.countryName);
              },
              height: 40,
              controller: widget.searchController,
              textInputAction: TextInputAction.done,
            ).addAllMargin(12),
            Expanded(
              child: commonWatch.isSearchCityBottomSheetLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                    )
                  : commonWatch.city.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          itemCount: commonWatch.city.length + (commonWatch.reachedCityLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index == commonWatch.city.length && commonWatch.city.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                widget.onTapItem(commonWatch.city[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: BodyMediumText(
                                    title: commonWatch.city[index].city ?? '',
                                    titleColor: ColorConstants.bottomTextColor),
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: BodyLargeText(
                              title: StringConstants.noDataFound,
                              fontFamily: FontWeightEnum.w600.toInter,
                            ),
                          ),
                        ),
            ),
            16.0.spaceY,
          ],
        ),
      ),
    );
  }
}
